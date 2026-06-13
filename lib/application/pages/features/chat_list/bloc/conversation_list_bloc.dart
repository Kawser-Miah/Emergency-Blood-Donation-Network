import 'dart:async';

import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/usecase/chat_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'conversation_list_event.dart';
import 'conversation_list_state.dart';

@injectable
class ConversationListBloc
    extends Bloc<ConversationListEvent, ConversationListState> {
  final ChatUseCase _useCase;

  StreamSubscription<List<Conversation>>? _sub;

  ConversationListBloc(this._useCase)
    : super(const ConversationListState.loading()) {
    on<ConversationListEvent>((event, emit) async {
      await event.when(
        watchStarted: (uid) async => _startWatching(uid),
        searchChanged: (value) async => _applySearch(value, emit),
        conversationsReceived: (conversations) async =>
            _emitLoaded(conversations, emit),
        errorOccurred: (message) async =>
            emit(ConversationListState.error(message)),
      );
    });
  }

  void _startWatching(String uid) {
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
    final search = state.maybeMap(loaded: (s) => s.search, orElse: () => '');
    final filtered = _filter(all, search);
    final totalUnread = all.fold<int>(
      0,
      (sum, c) => sum + (c.unreadCounts.values.fold(0, (a, b) => a + b)),
    );
    emit(
      ConversationListState.loaded(
        conversations: all,
        filtered: filtered,
        search: search,
        totalUnread: totalUnread,
      ),
    );
  }

  void _applySearch(String value, Emitter<ConversationListState> emit) {
    state.maybeMap(
      loaded: (s) => emit(
        s.copyWith(search: value, filtered: _filter(s.conversations, value)),
      ),
      orElse: () {},
    );
  }

  static List<Conversation> _filter(List<Conversation> all, String query) {
    if (query.isEmpty) return all;
    final q = query.toLowerCase();
    return all.where((c) {
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
