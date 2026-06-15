import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.input,
    required this.onChanged,
    required this.onSend,
    required this.onAttach,
    required this.onEmoji,
    required this.showEmojiPicker,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String input;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final VoidCallback onEmoji;
  final bool showEmojiPicker;

  @override
  Widget build(BuildContext context) {
    final hasText = input.trim().isNotEmpty;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.dividerLighter)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onAttach,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.dividerLightest,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.attach_file,
                  size: 18, color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              constraints:
                  const BoxConstraints(minHeight: 44, maxHeight: 80),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      maxLines: null,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Type a message...',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                      onSubmitted: (_) => onSend(),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  GestureDetector(
                    onTap: onEmoji,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        showEmojiPicker
                            ? Icons.keyboard_outlined
                            : Icons.emoji_emotions_outlined,
                        size: 18,
                        color: showEmojiPicker
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: hasText ? onSend : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hasText ? AppColors.primary : AppColors.divider,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
