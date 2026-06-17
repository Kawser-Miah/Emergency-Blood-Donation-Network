import 'dart:async';

import 'package:blood_setu/application/core/services/notification_service/notification_service.dart';
import 'package:blood_setu/domain/models/chat_source.dart';
import 'package:blood_setu/domain/models/message.dart';
import 'package:blood_setu/domain/models/message_status.dart';
import 'package:blood_setu/domain/models/message_type.dart';
import 'package:blood_setu/domain/models/presence_status.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/usecase/chat_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'chat_event.dart';
import 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase _useCase;
  final NotificationService _notificationService;

  StreamSubscription<List<Message>>? _sub;
  StreamSubscription<PresenceStatus>? _presenceSub;
  StreamSubscription<bool>? _typingSub;
  Timer? _typingTimer;
  bool _isTyping = false;

  String _conversationId = '';
  String _currentUid = '';
  String _otherUid = '';

  ChatBloc(this._useCase, this._notificationService)
      : super(const ChatState.loading()) {
    on<ChatEvent>((event, emit) async {
      await event.when(
        openRequested: (currentUid, otherUid, chatSource) async =>
            await _openRequested(currentUid, otherUid, chatSource, emit),
        watchStarted: (conversationId, currentUid, otherUid) async =>
            _startWatching(conversationId, currentUid, otherUid),
        messagesReceived: (messages) async => _emitReady(messages, emit),
        presenceChanged: (status) async => state.maybeMap(
          ready: (s) => emit(s.copyWith(
            otherOnline: status.online,
            otherLastSeen: status.lastSeen,
          )),
          orElse: () {},
        ),
        typingChanged: (isTyping) async => state.maybeMap(
          ready: (s) => emit(s.copyWith(showTyping: isTyping)),
          orElse: () {},
        ),
        inputChanged: (value) async {
          state.maybeMap(
            ready: (s) => emit(s.copyWith(input: value)),
            orElse: () {},
          );
          _handleTypingUpdate(value);
        },
        messageSent: (text) async => await _sendMessage(text, emit),
        attachmentToggled: () async => state.maybeMap(
          ready: (s) => emit(s.copyWith(showAttachment: !s.showAttachment)),
          orElse: () {},
        ),
        attachmentClosed: () async => state.maybeMap(
          ready: (s) => emit(s.copyWith(showAttachment: false)),
          orElse: () {},
        ),
        errorOccurred: (message) async => emit(ChatState.error(message)),
      );
    });
  }

  Future<void> _openRequested(
    String currentUid,
    String otherUid,
    ChatSource chatSource,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatState.loading());
    final result = await _useCase.getOrCreateConversation(
      currentUid: currentUid,
      otherUid: otherUid,
      chatSource: chatSource,
    );
    result.fold(
      (f) => add(
        ChatEvent.errorOccurred(
          f is GeneralFailure ? f.message : 'Failed to open chat',
        ),
      ),
      (conv) => _startWatching(conv.id, currentUid, otherUid),
    );
  }

  void _startWatching(
    String conversationId,
    String currentUid,
    String otherUid,
  ) {
    _conversationId = conversationId;
    _currentUid = currentUid;
    _otherUid = otherUid;
    _notificationService.setActiveConversation(_conversationId);

    // Mark as read immediately on open — fire-and-forget.
    _useCase.markAsRead(conversationId: _conversationId, uid: _currentUid);

    // Announce current user as online; RTDB onDisconnect handles going offline.
    _useCase
        .setOnlineStatus(_currentUid, true)
        .then(
          (result) => result.fold(
            (f) => add(
              ChatEvent.errorOccurred(
                f is GeneralFailure ? f.message : 'Presence error',
              ),
            ),
            (_) {},
          ),
        );

    // Watch the other participant's presence.
    _presenceSub?.cancel();
    _presenceSub = _useCase
        .watchPresence(_otherUid)
        .listen(
          (status) => add(ChatEvent.presenceChanged(status)),
          onError: (e) {
            debugPrint("User Active Status Error: ${e.toString()}");
          },
        );

    // Watch the other participant's typing status.
    _typingSub?.cancel();
    _typingSub = _useCase
        .watchTyping(conversationId: _conversationId, uid: _otherUid)
        .listen(
          (isTyping) => add(ChatEvent.typingChanged(isTyping)),
          onError: (e) => debugPrint('Typing watch error: $e'),
        );

    _sub?.cancel();
    _sub = _useCase
        .watchMessages(_conversationId)
        .listen(
          (messages) => add(ChatEvent.messagesReceived(messages)),
          onError: (Object e) => add(ChatEvent.errorOccurred(e.toString())),
        );
  }

  void _handleTypingUpdate(String value) {
    if (value.isEmpty) {
      _clearTyping();
      return;
    }

    // Restart the 5-second idle timer on every keystroke.
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 5), _clearTyping);

    // Only write to RTDB if not already flagged as typing.
    if (!_isTyping) {
      _isTyping = true;
      _useCase.setTyping(
        conversationId: _conversationId,
        uid: _currentUid,
        typing: true,
      );
    }
  }

  void _clearTyping() {
    _typingTimer?.cancel();
    _typingTimer = null;
    if (_isTyping) {
      _isTyping = false;
      _useCase.setTyping(
        conversationId: _conversationId,
        uid: _currentUid,
        typing: false,
      );
    }
  }

  void _emitReady(List<Message> messages, Emitter<ChatState> emit) {
    final current = state.maybeMap(ready: (s) => s, orElse: () => null);
    // Mark as read immediately on view msg.
    _useCase.markAsRead(conversationId: _conversationId, uid: _currentUid);
    emit(
      ChatState.ready(
        messages: messages,
        input: current?.input ?? '',
        showAttachment: current?.showAttachment ?? false,
        showTyping: current?.showTyping ?? false,
        otherOnline: current?.otherOnline ?? false,
        otherLastSeen: current?.otherLastSeen,
      ),
    );
  }

  Future<void> _sendMessage(String text, Emitter<ChatState> emit) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final current = state.maybeMap(ready: (s) => s, orElse: () => null);
    if (current == null) return;

    // Stop typing indicator when message is sent.
    _clearTyping();

    // Optimistic: add message locally before the Firestore write.
    final optimistic = Message(
      id: 'tmp_${DateTime.now().millisecondsSinceEpoch}',
      conversationId: _conversationId,
      senderId: _currentUid,
      text: trimmed,
      type: MessageType.text,
      timestamp: DateTime.now(),
      readBy: [_currentUid],
      status: MessageStatus.sending,
    );

    emit(
      current.copyWith(
        messages: [...current.messages, optimistic],
        input: '',
        showAttachment: false,
      ),
    );

    final result = await _useCase.sendMessage(
      conversationId: _conversationId,
      senderId: _currentUid,
      text: trimmed,
      type: MessageType.text,
    );
    result.fold(
      (f) {
        // Remove the stuck optimistic message on failure.
        final s = state.maybeMap(ready: (s) => s, orElse: () => null);
        if (s != null) {
          emit(
            s.copyWith(
              messages: s.messages.where((m) => m.id != optimistic.id).toList(),
            ),
          );
        }
      },
      (_) {}, // Success: Firestore stream will replace the optimistic entry.
    );
  }

  @override
  Future<void> close() async {
    _sub?.cancel();
    _presenceSub?.cancel();
    _typingSub?.cancel();
    _clearTyping();
    _notificationService.setActiveConversation(null);
    // Mark offline when leaving the chat screen.
    if (_currentUid.isNotEmpty) {
      await _useCase.setOnlineStatus(_currentUid, false);
    }
    return super.close();
  }
}
