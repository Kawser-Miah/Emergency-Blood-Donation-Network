import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/chat_navigation.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/pages/features/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_bloc.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_event.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/chat_contact.dart';
import 'package:blood_setu/domain/models/chat_screen_args.dart';
import 'package:blood_setu/domain/models/conversation.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/avatar.dart';

String _formatTime(DateTime dt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final msgDay = DateTime(dt.year, dt.month, dt.day);
  if (msgDay == today) {
    final h = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    final mm = dt.minute.toString().padLeft(2, '0');
    return '${h.toString().padLeft(2, '0')}:$mm $ampm';
  }
  if (msgDay == today.subtract(const Duration(days: 1))) return 'Yesterday';
  return '${dt.month}/${dt.day}';
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = getIt<AuthController>().user?.uid ?? '';
    return BlocProvider(
      create: (_) => getIt<ConversationListBloc>()
        ..add(ConversationListEvent.watchStarted(uid)),
      child: _ChatListView(currentUid: uid),
    );
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
          _Header(currentUid: currentUid),
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
                        ? _Empty(
                            onFind: () => context
                                .read<BottomNavBloc>()
                                .add(BottomNavEvent.tabChanged(index: 1)),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: filtered.length,
                            itemBuilder: (context, i) => _ChatRow(
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

class _Header extends StatelessWidget {
  const _Header({required this.currentUid});

  final String currentUid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).padding.top + 4,
        0,
        8,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ConversationListBloc, ConversationListState>(
            builder: (context, state) {
              final search = state.maybeMap(
                loaded: (s) => s.search,
                orElse: () => '',
              );
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.dividerLightest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          size: 15,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          search.isEmpty ? 'Search messages...' : search,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String _initialsFromName(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

class _ChatRow extends StatelessWidget {
  const _ChatRow({
    required this.conversation,
    required this.currentUid,
    required this.profiles,
  });

  final Conversation conversation;
  final String currentUid;
  final Map<String, UserProfileModel> profiles;

  @override
  Widget build(BuildContext context) {
    final otherUid = conversation.participantIds.firstWhere(
      (id) => id != currentUid,
      orElse: () => conversation.participantIds.first,
    );
    final stored = conversation.participants[otherUid];
    final profile = profiles[otherUid];

    // Use fresh profile data; fall back to stored snapshot while loading.
    final name = profile?.fullName?.isNotEmpty == true
        ? profile!.fullName!
        : (stored?.name ?? 'Unknown');
    final bloodGroup = profile?.bloodGroup ?? stored?.bloodGroup ?? '';
    final photoUrl = profile?.photoUrl;
    final initials = _initialsFromName(name);
    final avatarColor = stored?.avatarColor ?? chatAvatarColor(otherUid);
    final online = stored?.online ?? false;

    final unread = conversation.unreadCounts[currentUid] ?? 0;
    final hasUnread = unread > 0;

    final isMe = conversation.lastMessageSenderId == currentUid;
    final preview = conversation.lastMessage.isEmpty
        ? ''
        : isMe
            ? 'You: ${conversation.lastMessage}'
            : conversation.lastMessage;
    final timeStr = _formatTime(conversation.lastMessageTime);

    return InkWell(
      onTap: () {
        AppRouter.router.push(
          PAGES.chat.screenPath,
          extra: ChatScreenArgs(
            contact: ChatContact(
              id: otherUid,
              name: name,
              bloodGroup: bloodGroup,
              initials: initials,
              avatarColor: avatarColor,
              online: online,
              photoUrl: photoUrl,
            ),
            currentUid: currentUid,
            conversationId: conversation.id,
            otherUid: otherUid,
            chatSource: conversation.chatSource,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: hasUnread ? const Color(0xFFFFF9F9) : Colors.white,
          border: const Border(
            bottom: BorderSide(color: AppColors.dividerLighter),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Avatar(
              initials: initials,
              colorHex: avatarColor,
              imageUrl: photoUrl,
              size: 52,
              online: online,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: hasUnread
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (bloodGroup.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primarySurface,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Text(
                                  bloodGroup,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 11,
                          color: hasUnread
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: hasUnread
                                ? AppColors.textSecondary
                                : AppColors.textMuted,
                            fontWeight: hasUnread
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$unread',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onFind});

  final VoidCallback onFind;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('💬', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            const Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start by messaging a donor or responding to a blood request',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onFind,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Find Donors',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
