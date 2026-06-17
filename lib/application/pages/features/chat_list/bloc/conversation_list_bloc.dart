import 'dart:async';

import 'package:blood_setu/application/core/services/notification_service/notification_service.dart';
import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/usecase/chat_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'conversation_list_event.dart';
import 'conversation_list_state.dart';

@injectable
class ConversationListBloc
    extends Bloc<ConversationListEvent, ConversationListState> {
  final ChatUseCase _useCase;
  final NotificationService _notificationService;

  StreamSubscription<List<Conversation>>? _sub;
  String _currentUid = '';
  bool _refreshProfiles = false;
  Map<String, int> _prevUnreadCounts = {};

  ConversationListBloc(this._useCase, this._notificationService)
    : super(const ConversationListState.loading()) {
    on<ConversationListEvent>((event, emit) async {
      await event.when(
        watchStarted: (uid) async => _startWatching(uid),
        searchChanged: (value) async => _applySearch(value, emit),
        conversationsReceived: (conversations) async =>
            _emitLoaded(conversations, emit),
        errorOccurred: (message) async =>
            emit(ConversationListState.error(message)),
        profilesFetched: (profiles) async => _mergeProfiles(profiles, emit),
      );
    });
  }

  void _startWatching(String uid) {
    _currentUid = uid;
    _refreshProfiles = true;
    _prevUnreadCounts = {};
    _sub?.cancel();
    _sub = _useCase.watchConversations(uid).listen(
      (conversations) =>
          add(ConversationListEvent.conversationsReceived(conversations)),
      onError: (Object e) =>
          add(ConversationListEvent.errorOccurred(e.toString())),
    );
  }

  void _emitLoaded(
    List<Conversation> all,
    Emitter<ConversationListState> emit,
  ) {
    final existing = state.maybeMap(
      loaded: (s) => s,
      orElse: () => null,
    );
    final search = existing?.search ?? '';

    // Clear cached profiles when watchStarted fires so stale data is discarded.
    final profiles = _refreshProfiles
        ? const <String, UserProfileModel>{}
        : (existing?.profiles ?? const <String, UserProfileModel>{});
    _refreshProfiles = false;

    final filtered = _filter(all, search, _currentUid, profiles);
    final totalUnread = all.fold<int>(
      0,
      (sum, c) => sum + (c.unreadCounts[_currentUid] ?? 0),
    );
    emit(
      ConversationListState.loaded(
        conversations: all,
        filtered: filtered,
        search: search,
        totalUnread: totalUnread,
        profiles: profiles,
      ),
    );

    if (_prevUnreadCounts.isNotEmpty) {
      for (final conv in all) {
        final newCount = conv.unreadCounts[_currentUid] ?? 0;
        final prevCount = _prevUnreadCounts[conv.id] ?? 0;
        if (newCount > prevCount &&
            conv.lastMessageSenderId != _currentUid &&
            conv.lastMessage.isNotEmpty) {
          final senderUid = conv.lastMessageSenderId;
          final profile = profiles[senderUid];
          final participant = conv.participants[senderUid];
          final name = profile?.fullName ?? participant?.name ?? 'New message';
          _notificationService.showChatNotification(
            conversationId: conv.id,
            senderName: name,
            messageText: conv.lastMessage,
            currentUid: _currentUid,
            otherUid: senderUid,
            messageTime: conv.lastMessageTime,
            bloodGroup: participant?.bloodGroup ?? '',
            initials: participant?.initials ?? '',
            avatarColor: participant?.avatarColor ?? '',
          );
        }
      }
    }
    _prevUnreadCounts = {
      for (final c in all) c.id: c.unreadCounts[_currentUid] ?? 0
    };

    // Fetch profiles for all participants not yet in cache.
    final knownUids = profiles.keys.toSet();
    final uidsToFetch = all
        .expand((c) => c.participantIds.where((id) => id != _currentUid))
        .toSet()
        .difference(knownUids)
        .toList();
    if (uidsToFetch.isNotEmpty) {
      _useCase.fetchProfiles(uidsToFetch).then(
        (fetched) => add(ConversationListEvent.profilesFetched(fetched)),
      );
    }
  }

  void _mergeProfiles(
    Map<String, UserProfileModel> incoming,
    Emitter<ConversationListState> emit,
  ) {
    state.maybeMap(
      loaded: (s) {
        final merged = {...s.profiles, ...incoming};
        final filtered = _filter(s.conversations, s.search, _currentUid, merged);
        emit(s.copyWith(profiles: merged, filtered: filtered));
      },
      orElse: () {},
    );
  }

  void _applySearch(String value, Emitter<ConversationListState> emit) {
    state.maybeMap(
      loaded: (s) => emit(
        s.copyWith(
          search: value,
          filtered: _filter(s.conversations, value, _currentUid, s.profiles),
        ),
      ),
      orElse: () {},
    );
  }

  static List<Conversation> _filter(
    List<Conversation> all,
    String query,
    String currentUid,
    Map<String, UserProfileModel> profiles,
  ) {
    if (query.isEmpty) return all;
    final q = query.toLowerCase();
    return all.where((c) {
      final otherUid = c.participantIds.firstWhere(
        (id) => id != currentUid,
        orElse: () => '',
      );
      final profile = profiles[otherUid];
      if (profile != null) {
        return (profile.fullName ?? '').toLowerCase().contains(q) ||
            (profile.bloodGroup ?? '').toLowerCase().contains(q);
      }
      // Fall back to stored data while profile is loading.
      return c.participants.values.any(
        (p) =>
            p.name.toLowerCase().contains(q) ||
            p.bloodGroup.toLowerCase().contains(q),
      );
    }).toList();
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
