import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

String _lastDonatedLabel(DateTime? lastDonation) {
  if (lastDonation == null) return '—';
  final days = DateTime.now().difference(lastDonation).inDays;
  if (days == 0) return 'Today';
  if (days == 1) return '1d ago';
  return '${days}d ago';
}

class ProfilePersonalInfoSection extends StatelessWidget {
  const ProfilePersonalInfoSection({
    super.key,
    required this.profile,
    required this.expanded,
    required this.onToggle,
  });

  final UserProfileModel? profile;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final p = profile;
    final lastDonation =
        p?.lastDonation != null ? _lastDonatedLabel(p!.lastDonation) : '—';

    final items = [
      _InfoItem(label: 'Full Name', value: p?.fullName ?? '—'),
      _InfoItem(label: 'Gender', value: p?.gender ?? '—'),
      _InfoItem(label: 'Age', value: p?.age != null ? '${p!.age}' : '—'),
      _InfoItem(label: 'Phone', value: p?.phone ?? '—'),
      _InfoItem(label: 'District', value: p?.district ?? '—'),
      _InfoItem(label: 'Thana', value: p?.thana ?? '—'),
      _InfoItem(label: 'Last Donation', value: lastDonation),
      _InfoItem(label: 'Facebook ID', value: p?.fbId ?? '—'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '👤 Personal Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: expanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.expand_more,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: List.generate(items.length, (i) {
                  final item = items[i];
                  return Container(
                    decoration: BoxDecoration(
                      border: i < items.length - 1
                          ? const Border(
                              bottom: BorderSide(
                                color: AppColors.dividerLightest,
                              ),
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.label,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              Text(
                                item.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.edit,
                          size: 14,
                          color: AppColors.textDisabled,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoItem {
  const _InfoItem({required this.label, required this.value});
  final String label;
  final String value;
}
