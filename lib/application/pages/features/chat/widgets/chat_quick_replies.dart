import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

const List<String> kQuickReplies = [
  "I'm coming",
  "Need 30 min",
  "Call me",
  "On the way 🚗",
];

class ChatQuickReplies extends StatelessWidget {
  const ChatQuickReplies({super.key, required this.onTap});

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        itemCount: kQuickReplies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final r = kQuickReplies[i];
          return GestureDetector(
            onTap: () => onTap(r),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Text(
                r,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
