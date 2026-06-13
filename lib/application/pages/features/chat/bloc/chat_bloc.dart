import 'dart:async';

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

  StreamSubscription<List<Message>>? _sub;
  StreamSubscription<PresenceStatus>? _presenceSub;
  String _conversationId = '';
  String _currentUid = '';
  String _otherUid = '';

  ChatBloc(this._useCase) : super(const ChatState.loading()) {
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
        inputChanged: (value) async => state.maybeMap(
          ready: (s) => emit(s.copyWith(input: value)),
          orElse: () {},
        ),
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

    _sub?.cancel();
    _sub = _useCase
        .watchMessages(_conversationId)
        .listen(
          (messages) => add(ChatEvent.messagesReceived(messages)),
          onError: (Object e) => add(ChatEvent.errorOccurred(e.toString())),
        );
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
        showTyping: false,
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
    // Mark offline when leaving the chat screen.
    if (_currentUid.isNotEmpty) {
      await _useCase.setOnlineStatus(_currentUid, false);
    }
    return super.close();
  }
}
