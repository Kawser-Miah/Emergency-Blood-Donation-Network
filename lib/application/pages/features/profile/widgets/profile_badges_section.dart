import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class _BadgeDef {
  const _BadgeDef({
    required this.name,
    required this.emoji,
    required this.requirement,
    required this.threshold,
    required this.color,
  });

  final String name;
  final String emoji;
  final String requirement;
  final int threshold;
  final Color color;
}

const _badgeDefs = [
  _BadgeDef(
    name: 'Bronze Helper',
    emoji: '🥉',
    requirement: '3 donations',
    threshold: 3,
    color: AppColors.bronze,
  ),
  _BadgeDef(
    name: 'Silver Guardian',
    emoji: '🥈',
    requirement: '6 donations',
    threshold: 6,
    color: AppColors.silver,
  ),
  _BadgeDef(
    name: 'Gold Lifesaver',
    emoji: '🥇',
    requirement: '12 donations',
    threshold: 12,
    color: AppColors.gold,
  ),
  _BadgeDef(
    name: 'Platinum Hero',
    emoji: '🏆',
    requirement: '25 donations',
    threshold: 25,
    color: AppColors.divider,
  ),
];

class ProfileBadgesSection extends StatelessWidget {
  const ProfileBadgesSection({super.key, required this.totalDonations});

  final int totalDonations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🏅 Achievements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _badgeDefs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, i) =>
                _BadgeCard(def: _badgeDefs[i], totalDonations: totalDonations),
          ),
        ),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.def, required this.totalDonations});

  final _BadgeDef def;
  final int totalDonations;

  @override
  Widget build(BuildContext context) {
    final unlocked = totalDonations >= def.threshold;
    final progress = totalDonations.clamp(0, def.threshold);

    return Opacity(
      opacity: unlocked ? 1 : 0.6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: def.color.withValues(alpha: 0.13),
                shape: BoxShape.circle,
                border: Border.all(color: def.color, width: 2),
              ),
              child: Text(def.emoji, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 8),
            Text(
              def.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              def.requirement,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
            ),
            if (!unlocked) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: SizedBox(
                  height: 3,
                  child: Stack(
                    children: [
                      Container(color: AppColors.dividerLight),
                      FractionallySizedBox(
                        widthFactor: progress / def.threshold,
                        child: Container(color: def.color),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$progress/${def.threshold}',
                style: const TextStyle(fontSize: 8, color: AppColors.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
