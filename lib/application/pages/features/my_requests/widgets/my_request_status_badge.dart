import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../../domain/models/blood_request_enums.dart';

class MyRequestStatusBadge extends StatelessWidget {
  const MyRequestStatusBadge({super.key, required this.status});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bg;
    String label;
    switch (status) {
      case RequestStatus.active:
        color = AppColors.success;
        bg = AppColors.successSurface;
        label = '● Active';
      case RequestStatus.fulfilled:
        color = AppColors.info;
        bg = AppColors.infoSurface;
        label = '✓ Fulfilled';
      case RequestStatus.cancelled:
        color = AppColors.textMuted;
        bg = AppColors.dividerLightest;
        label = '✗ Cancelled';
      case RequestStatus.expired:
        color = AppColors.warning;
        bg = AppColors.warningSurface;
        label = '⚠ Expired';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
