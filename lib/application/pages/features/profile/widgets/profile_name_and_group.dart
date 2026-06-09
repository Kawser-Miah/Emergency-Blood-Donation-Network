import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ProfileNameAndGroup extends StatelessWidget {
  const ProfileNameAndGroup({super.key, required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final name = profile?.fullName ?? '—';
    final bloodGroup = profile?.bloodGroup;
    final district = profile?.district ?? '';
    final thana = profile?.thana ?? '';
    final location = [thana, district].where((s) => s.isNotEmpty).join(', ');

    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bloodGroup != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                    color: AppColors.primaryBorder,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '$bloodGroup Donor',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (location.isNotEmpty) const SizedBox(width: 8),
            ],
            if (location.isNotEmpty)
              Text(
                location,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
