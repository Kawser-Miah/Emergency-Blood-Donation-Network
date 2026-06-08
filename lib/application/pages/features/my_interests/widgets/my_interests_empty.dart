import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:flutter/material.dart';

class MyInterestsEmpty extends StatelessWidget {
  const MyInterestsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.water_drop_outlined,
            size: 56,
            color: AppColors.primaryBorder,
          ),
          SizedBox(height: 12),
          Text(
            "You haven't shown interest in any requests yet.",
            style: TextStyle(fontSize: 15, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
