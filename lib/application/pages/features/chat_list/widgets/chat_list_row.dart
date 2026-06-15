import 'package:flutter/material.dart';

import '../../../../core/services/routing/app_router.dart';
import '../../../../core/services/routing/chat_navigation.dart';
import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../../domain/models/chat_contact.dart';
import '../../../../../domain/models/chat_screen_args.dart';
import '../../../../../domain/models/conversation.dart';
import '../../../../../domain/models/user_profile_model.dart';

String chatListFormatTime(DateTime dt) {
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

String chatListInitialsFromName(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

class ChatListRow extends StatelessWidget {
  const ChatListRow({
    super.key,
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

    final name = profile?.fullName?.isNotEmpty == true
        ? profile!.fullName!
        : (stored?.name ?? 'Unknown');
    final bloodGroup = profile?.bloodGroup ?? stored?.bloodGroup ?? '';
    final photoUrl = profile?.photoUrl;
    final initials = chatListInitialsFromName(name);
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
    final timeStr = chatListFormatTime(conversation.lastMessageTime);

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
