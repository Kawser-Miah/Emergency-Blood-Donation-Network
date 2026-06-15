import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_controller.dart';
import '../../../../core/theme/colors.dart';
import '../../../../../di/di.dart';
import '../bloc/conversation_list_bloc.dart';
import '../bloc/conversation_list_event.dart';
import '../bloc/conversation_list_state.dart';
import '../../bottom_nav/bloc/bottom_nav_bloc.dart';
import '../widgets/chat_list_empty.dart';
import '../widgets/chat_list_header.dart';
import '../widgets/chat_list_row.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final String _uid;

  @override
  void initState() {
    super.initState();
    _uid = getIt<AuthController>().user?.uid ?? '';
    context
        .read<ConversationListBloc>()
        .add(ConversationListEvent.watchStarted(_uid));
  }

  @override
  Widget build(BuildContext context) {
    return _ChatListView(currentUid: _uid);
  }
}

class _ChatListView extends StatelessWidget {
  const _ChatListView({required this.currentUid});

  final String currentUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ChatListHeader(currentUid: currentUid),
          Expanded(
            child: BlocBuilder<ConversationListBloc, ConversationListState>(
              builder: (context, state) => state.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (msg) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textTertiary),
                    ),
                  ),
                ),
                loaded: (conversations, filtered, search, totalUnread,
                        profiles) =>
                    filtered.isEmpty
                        ? ChatListEmpty(
                            onFind: () => context
                                .read<BottomNavBloc>()
                                .add(BottomNavEvent.tabChanged(index: 1)),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: filtered.length,
                            itemBuilder: (context, i) => ChatListRow(
                              conversation: filtered[i],
                              currentUid: currentUid,
                              profiles: profiles,
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
