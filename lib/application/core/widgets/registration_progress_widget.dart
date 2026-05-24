import 'package:flutter/material.dart';

import '../theme/colors.dart';

class RegistrationProgressWidget extends StatelessWidget {
  const RegistrationProgressWidget({
    super.key,
    required this.step,
    this.onStepTap,
  });

  final int step;
  final void Function(int)? onStepTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final s in [1, 2]) ...[
                GestureDetector(
                  onTap: (onStepTap != null && s < step)
                      ? () => onStepTap!(s)
                      : null,
                  child: _stepCircle(s, step),
                ),
                if (s < 2)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: step > 1 ? AppColors.primary : AppColors.divider,
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Step $step of 2',
            style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(int s, int currentStep) {
    final isActive = s <= currentStep;
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.divider,
        shape: BoxShape.circle,
      ),
      child: s < currentStep
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : Text(
              '$s',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textMuted,
              ),
            ),
    );
  }
}
