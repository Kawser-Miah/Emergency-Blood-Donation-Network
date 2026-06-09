import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';

class _BadgeDef {
  const _BadgeDef({
    required this.name,
    required this.emoji,
    required this.rangeLabel,
    required this.threshold,
    required this.color,
    required this.surface,
  });

  final String name;
  final String emoji;
  final String rangeLabel;
  final int threshold;
  final Color color;
  final Color surface;
}

const _badgeDefs = [
  _BadgeDef(
    name: 'Bronze\nHelper',
    emoji: '🥉',
    rangeLabel: '1+',
    threshold: 1,
    color: AppColors.bronze,
    surface: Color(0xFFFBF0E6),
  ),
  _BadgeDef(
    name: 'Silver\nGuardian',
    emoji: '🥈',
    rangeLabel: '6+',
    threshold: 6,
    color: AppColors.silver,
    surface: Color(0xFFF2F2F3),
  ),
  _BadgeDef(
    name: 'Gold\nLifesaver',
    emoji: '🥇',
    rangeLabel: '12+',
    threshold: 12,
    color: AppColors.goldDark,
    surface: Color(0xFFFFF8E1),
  ),
  _BadgeDef(
    name: 'Platinum\nHero',
    emoji: '🏆',
    rangeLabel: '25+',
    threshold: 25,
    color: Color(0xFF546E7A),
    surface: Color(0xFFECEFF1),
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
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 12),
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
                onPressed: () => context.push(
                  PAGES.allBadges.screenPath,
                  extra: totalDonations,
                ),
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
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _badgeDefs.length,
            separatorBuilder: (_, i) => const SizedBox(width: 10),
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

    return Container(
      width: 110,
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: unlocked
            ? Border.all(color: def.color.withValues(alpha: 0.4), width: 1.5)
            : Border.all(color: AppColors.dividerLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + status indicator row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: unlocked ? def.surface : AppColors.dividerLightest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Opacity(
                    opacity: unlocked ? 1.0 : 0.35,
                    child: Text(def.emoji, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: unlocked ? AppColors.successSurface : AppColors.dividerLightest,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: unlocked ? AppColors.success : AppColors.divider,
                    width: 1.2,
                  ),
                ),
                child: Icon(
                  unlocked ? Icons.check_rounded : Icons.lock_rounded,
                  size: 10,
                  color: unlocked ? AppColors.success : AppColors.textDisabled,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Name
          Text(
            def.name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: unlocked ? AppColors.textPrimary : AppColors.textTertiary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${def.rangeLabel} donations',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: unlocked ? def.color : AppColors.textMuted,
            ),
          ),
          const Spacer(),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress / def.threshold,
              minHeight: 4,
              backgroundColor: AppColors.dividerLight,
              valueColor: AlwaysStoppedAnimation(
                unlocked ? def.color : AppColors.textDisabled,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$progress / ${def.threshold}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: unlocked ? def.color : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
