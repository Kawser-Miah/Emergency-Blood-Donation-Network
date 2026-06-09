import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

// ─── Badge definitions ────────────────────────────────────────────────────────

class _BadgeDef {
  const _BadgeDef({
    required this.name,
    required this.emoji,
    required this.rangeLabel,
    required this.description,
    required this.threshold,
    required this.color,
    required this.surface,
  });

  final String name;
  final String emoji;
  final String rangeLabel;
  final String description;
  final int threshold;
  final Color color;
  final Color surface;
}

const _badges = [
  _BadgeDef(
    name: 'Bronze Helper',
    emoji: '🥉',
    rangeLabel: '1+ donations',
    description: 'You took your first step as a blood donor.',
    threshold: 1,
    color: AppColors.bronze,
    surface: Color(0xFFFBF0E6),
  ),
  _BadgeDef(
    name: 'Silver Guardian',
    emoji: '🥈',
    rangeLabel: '6+ donations',
    description: 'A dedicated guardian — your regularity saves lives.',
    threshold: 6,
    color: AppColors.silver,
    surface: Color(0xFFF2F2F3),
  ),
  _BadgeDef(
    name: 'Gold Lifesaver',
    emoji: '🥇',
    rangeLabel: '12+ donations',
    description: 'Recognized for consistent, long-term commitment.',
    threshold: 12,
    color: AppColors.goldDark,
    surface: Color(0xFFFFF8E1),
  ),
  _BadgeDef(
    name: 'Platinum Hero',
    emoji: '🏆',
    rangeLabel: '25+ donations',
    description: 'The highest honor — an extraordinary life hero.',
    threshold: 25,
    color: Color(0xFF546E7A),
    surface: Color(0xFFECEFF1),
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class AllBadgesScreen extends StatelessWidget {
  const AllBadgesScreen({super.key, required this.totalDonations});

  final int totalDonations;

  @override
  Widget build(BuildContext context) {
    final unlocked = _badges.where((b) => totalDonations >= b.threshold).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        title: const Text(
          'Achievements',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ProgressHeader(
              totalDonations: totalDonations,
              unlocked: unlocked,
              total: _badges.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList.separated(
              itemCount: _badges.length,
              separatorBuilder: (context, i) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _BadgeCard(
                def: _badges[i],
                totalDonations: totalDonations,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Progress header ──────────────────────────────────────────────────────────

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.totalDonations,
    required this.unlocked,
    required this.total,
  });

  final int totalDonations;
  final int unlocked;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = unlocked / total;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$unlocked of $total badges',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      unlocked == total
                          ? 'All badges unlocked — legendary!'
                          : 'Keep donating to unlock more',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryBorder, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '🩸',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalDonations donation${totalDonations != 1 ? 's' : ''} total',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${(ratio * 100).round()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: AppColors.dividerLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Badge card ───────────────────────────────────────────────────────────────

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.def, required this.totalDonations});

  final _BadgeDef def;
  final int totalDonations;

  @override
  Widget build(BuildContext context) {
    final unlocked = totalDonations >= def.threshold;
    final progress = totalDonations.clamp(0, def.threshold);
    final ratio = progress / def.threshold;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: unlocked
            ? Border.all(color: def.color.withValues(alpha: 0.35), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: unlocked ? def.surface : AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: unlocked
                          ? def.color.withValues(alpha: 0.4)
                          : AppColors.divider,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: unlocked ? 1.0 : 0.4,
                      child: Text(
                        def.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        def.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: unlocked
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        def.rangeLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: unlocked ? def.color : AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        def.description,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status chip
                _StatusChip(unlocked: unlocked, color: def.color),
              ],
            ),
            const SizedBox(height: 14),
            // Progress row
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: ratio,
                      minHeight: 6,
                      backgroundColor: AppColors.dividerLight,
                      valueColor: AlwaysStoppedAnimation(
                        unlocked ? def.color : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$progress / ${def.threshold}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: unlocked ? def.color : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.unlocked, required this.color});

  final bool unlocked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (unlocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.successSurface,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: AppColors.success.withValues(alpha: 0.4),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, size: 12, color: AppColors.success),
            SizedBox(width: 4),
            Text(
              'Unlocked',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.dividerLightest,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: AppColors.divider),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline_rounded, size: 12, color: AppColors.textMuted),
          SizedBox(width: 4),
          Text(
            'Locked',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
