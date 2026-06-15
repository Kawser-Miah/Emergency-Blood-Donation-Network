import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../../domain/models/user_profile_model.dart';

class HomeWelcomeCard extends StatelessWidget {
  const HomeWelcomeCard({super.key, required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final name = profile?.fullName ?? 'Guest';
    final tier = profile?.donorTier ?? '';
    final donations = profile?.totalDonations ?? 0;
    final days = profile?.daysToNextDonation ?? 0;
    final isActive = profile?.isActive ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primarySurfaceLight, AppColors.primarySurface],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello 👋',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (tier.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.gold, AppColors.goldDark],
                    ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    '🏆 $tier',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _HomeStat(
                  emoji: '🩸',
                  value: '$donations',
                  label: 'Donations',
                  color: AppColors.primary,
                ),
                const _HomeVStat(),
                _HomeStat(
                  emoji: '⏳',
                  value: '$days',
                  label: 'Days to Donate',
                  color: AppColors.info,
                ),
                const _HomeVStat(),
                _HomeStat(
                  emoji: isActive ? '🟢' : '🔴',
                  value: isActive ? 'Active' : 'Inactive',
                  label: 'Status',
                  color: isActive ? AppColors.success : AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeStat extends StatelessWidget {
  const _HomeStat({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  final String emoji;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeVStat extends StatelessWidget {
  const _HomeVStat();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 32, color: AppColors.primaryBorder);
  }
}
