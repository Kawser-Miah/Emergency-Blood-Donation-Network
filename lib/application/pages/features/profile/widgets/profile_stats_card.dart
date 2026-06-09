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

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key, required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final donations = profile?.totalDonations ?? 0;
    final days = profile?.daysToNextDonation ?? 0;
    final nextEligible = days <= 0 ? 'Now' : '${days}d';
    final lastDonated = _lastDonatedLabel(profile?.lastDonation);

    final stats = [
      _StatEntry(
        value: '$donations',
        label: 'Donations',
        emoji: '🩸',
        color: AppColors.primary,
      ),
      _StatEntry(
        value: nextEligible,
        label: 'Next Eligible',
        emoji: '📅',
        color: days <= 0 ? AppColors.success : AppColors.info,
      ),
      _StatEntry(
        value: lastDonated,
        label: 'Last Donated',
        emoji: '⏱️',
        color: AppColors.info,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: List.generate(stats.length, (i) {
            final s = stats[i];
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: i < stats.length - 1
                      ? const Border(
                          right: BorderSide(color: AppColors.dividerLightest),
                        )
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      '${s.emoji} ${s.value}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: s.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s.label,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _StatEntry {
  const _StatEntry({
    required this.value,
    required this.label,
    required this.emoji,
    required this.color,
  });

  final String value;
  final String label;
  final String emoji;
  final Color color;
}
