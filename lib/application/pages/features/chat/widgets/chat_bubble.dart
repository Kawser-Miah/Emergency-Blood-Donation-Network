import 'package:flutter/material.dart';

import '../../../../../domain/models/chat_contact.dart';
import '../../../../../domain/models/message.dart';
import '../../../../../domain/models/message_status.dart';
import '../../../../core/theme/colors.dart';
import 'chat_helpers.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.contact,
    required this.currentUid,
  });

  final Message message;
  final ChatContact contact;
  final String currentUid;

  @override
  Widget build(BuildContext context) {
    final isSent = message.senderId == currentUid;
    final isRead = message.status == MessageStatus.read ||
        message.readBy.length > 1;
    final isSending = message.status == MessageStatus.sending;

    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Column(
              crossAxisAlignment:
                  isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSent
                        ? AppColors.primary
                        : AppColors.dividerLight,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isSent ? 16 : 4),
                      bottomRight: Radius.circular(isSent ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSent ? Colors.white : AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatTime(message.timestamp),
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted),
                    ),
                    if (isSent) ...[
                      const SizedBox(width: 4),
                      isSending
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: AppColors.textMuted,
                            )
                          : Text(
                              '✓✓',
                              style: TextStyle(
                                fontSize: 10,
                                color: isRead
                                    ? AppColors.info
                                    : AppColors.textMuted,
                              ),
                            ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
