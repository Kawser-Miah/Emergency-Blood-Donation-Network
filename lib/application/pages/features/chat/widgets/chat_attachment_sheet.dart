import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';

class ChatAttachmentItem {
  ChatAttachmentItem({
    this.icon,
    this.emoji,
    required this.label,
    required this.color,
  });

  final IconData? icon;
  final String? emoji;
  final String label;
  final Color color;
}

class ChatAttachmentSheet extends StatelessWidget {
  const ChatAttachmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ChatAttachmentItem(
          icon: Icons.camera_alt, label: 'Camera', color: AppColors.info),
      ChatAttachmentItem(
          icon: Icons.image, label: 'Gallery', color: AppColors.success),
      ChatAttachmentItem(
          icon: Icons.location_on, label: 'Location', color: AppColors.warning),
      ChatAttachmentItem(
          emoji: '🩸', label: 'Certificate', color: AppColors.primary),
    ];

    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context
                .read<ChatBloc>()
                .add(const ChatEvent.attachmentClosed()),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.9,
                    children: items
                        .map(
                          (it) => InkWell(
                            onTap: () => context
                                .read<ChatBloc>()
                                .add(const ChatEvent.attachmentClosed()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        it.color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: it.emoji != null
                                      ? Text(
                                          it.emoji!,
                                          style: const TextStyle(fontSize: 22),
                                        )
                                      : Icon(it.icon,
                                          size: 22, color: it.color),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  it.label,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
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
