import 'package:flutter/material.dart';

import '../theme/colors.dart';

class RegistrationHeaderWidget extends StatelessWidget {
  const RegistrationHeaderWidget({super.key});

  // final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 4,
        16,
        16,
      ),
      child: Row(
        children: [
          // IconButton(
          //   onPressed: onBack,
          //   icon: const Icon(Icons.arrow_back, size: 20),
          //   color: AppColors.textTertiary,
          //   padding: const EdgeInsets.all(4),
          //   constraints: const BoxConstraints(),
          // ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Complete Your Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'This helps us match you with blood seekers',
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
