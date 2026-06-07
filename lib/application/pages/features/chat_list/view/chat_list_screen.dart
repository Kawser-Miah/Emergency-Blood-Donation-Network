import 'package:flutter/material.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../domain/models/chat_summary.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/typing_dots.dart';
import '../../../../core/theme/colors.dart';


class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              _Header(),
              Expanded(
                child: mockChats.isEmpty
                    ? _Empty(
                        onFind: () {},
                            // context.read<AppNavigationBloc>().add(
                            //   const AppNavigationEvent.navigated(
                            //       AppScreen.donors),
                            // ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: mockChats.length,
                        itemBuilder: (context, i) {
                          final chat = mockChats[i];
                          return _ChatRow(chat: chat);
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 4, 0, 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 20),
                      color: AppColors.textTertiary,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 20),
                      color: AppColors.textTertiary,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, size: 15, color: AppColors.textMuted),
                  SizedBox(width: 8),
                  Text(
                    'Search messages...',
                    style:
                        TextStyle(fontSize: 14, color: AppColors.textDisabled),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatRow extends StatelessWidget {
  const _ChatRow({required this.chat});

  final ChatSummary chat;

  @override
  Widget build(BuildContext context) {
    final hasUnread = chat.unread > 0;
    return InkWell(
      onTap: () {},
          // context.read<AppNavigationBloc>().add(
          //   AppNavigationEvent.navigated(
          //     AppScreen.chat,
          //     contact: ChatContact(
          //       name: chat.name,
          //       bloodGroup: chat.bloodGroup,
          //       id: chat.id,
          //       initials: chat.initials,
          //       avatarColor: chat.avatarColor,
          //       online: chat.online,
          //     ),
          //   ),
          // ),
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
              initials: chat.initials,
              colorHex: chat.avatarColor,
              size: 52,
              online: chat.online,
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
                                chat.name,
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
                            if (chat.bloodGroup.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primarySurface,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Text(
                                  chat.bloodGroup,
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
                        chat.time,
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
                        child: chat.typing
                            ? Row(
                                children: const [
                                  TypingDotsList(),
                                  SizedBox(width: 6),
                                  Text(
                                    'typing...',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.success,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                chat.lastMessage,
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
                            '${chat.unread}',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
