import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../widgets/bottom_nav.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class _Badge {
  const _Badge({
    required this.id,
    required this.name,
    required this.emoji,
    required this.requirement,
    required this.progress,
    required this.total,
    required this.unlocked,
    required this.color,
  });

  final String id;
  final String name;
  final String emoji;
  final String requirement;
  final int progress;
  final int total;
  final bool unlocked;
  final Color color;
}

const List<_Badge> _badges = [
  _Badge(
    id: '1',
    name: 'Bronze Helper',
    emoji: '🥉',
    requirement: '3 donations',
    progress: 3,
    total: 3,
    unlocked: true,
    color: AppColors.bronze,
  ),
  _Badge(
    id: '2',
    name: 'Silver Guardian',
    emoji: '🥈',
    requirement: '6 donations',
    progress: 6,
    total: 6,
    unlocked: true,
    color: AppColors.silver,
  ),
  _Badge(
    id: '3',
    name: 'Gold Lifesaver',
    emoji: '🥇',
    requirement: '12 donations',
    progress: 12,
    total: 12,
    unlocked: true,
    color: AppColors.gold,
  ),
  _Badge(
    id: '4',
    name: 'Platinum Hero',
    emoji: '🏆',
    requirement: '25 donations',
    progress: 12,
    total: 25,
    unlocked: false,
    color: AppColors.divider,
  ),
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 96),
                child: Column(
                  children: [
                    const _CoverPhoto(),
                    const SizedBox(height: 64),
                    const _NameAndGroup(),
                    const SizedBox(height: 16),
                    const _StatsCard(),
                    const SizedBox(height: 16),
                    const _BadgesSection(),
                    const SizedBox(height: 16),
                    const _DonationHistorySection(),
                    const SizedBox(height: 16),
                    _PersonalInfoSection(
                      expanded: state.infoExpanded,
                      onToggle: () => context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.infoExpandedToggled()),
                    ),
                    const SizedBox(height: 16),
                    _SettingsSection(state: state),
                  ],
                ),
              ),
              const BottomNav(active: 'profile'),
            ],
          ),
        );
      },
    );
  }
}

class _CoverPhoto extends StatelessWidget {
  const _CoverPhoto();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200 + MediaQuery.of(context).padding.top,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryDark, AppColors.primary],
                ),
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.avatarPurple,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'RU',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.edit,
                            size: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameAndGroup extends StatelessWidget {
  const _NameAndGroup();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Rahmat Ullah',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColors.primaryBorder, width: 1.5),
              ),
              child: const Text(
                'O+ Donor',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Mirpur, Dhaka',
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatEntry(value: '12', label: 'Donations', emoji: '🩸', color: AppColors.primary),
      _StatEntry(value: '8', label: 'Lives Saved', emoji: '❤️', color: AppColors.primary),
      _StatEntry(value: '18m', label: 'Avg Response', emoji: '⏱️', color: AppColors.info),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
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
                          right: BorderSide(
                              color: AppColors.dividerLightest),
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
                          fontSize: 11, color: AppColors.textMuted),
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

class _BadgesSection extends StatelessWidget {
  const _BadgesSection();

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
            itemCount: _badges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) => _BadgeCard(badge: _badges[i]),
          ),
        ),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final _Badge badge;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: badge.unlocked ? 1 : 0.6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
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
                color: badge.color.withOpacity(0.13),
                shape: BoxShape.circle,
                border: Border.all(color: badge.color, width: 2),
              ),
              child: Text(badge.emoji, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 8),
            Text(
              badge.name,
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
              badge.requirement,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
            ),
            if (!badge.unlocked) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: SizedBox(
                  height: 3,
                  child: Stack(
                    children: [
                      Container(color: AppColors.dividerLight),
                      FractionallySizedBox(
                        widthFactor: badge.progress / badge.total,
                        child: Container(color: badge.color),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${badge.progress}/${badge.total}',
                style: const TextStyle(fontSize: 8, color: AppColors.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DonationHistorySection extends StatelessWidget {
  const _DonationHistorySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🩸 Recent Donations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final d in mockDonationHistory) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('🩸', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.hospital,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${d.date} • ${d.bloodGroup}',
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.successSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '✓ ${d.status}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.download,
                      size: 14, color: AppColors.textMuted),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _PersonalInfoSection extends StatelessWidget {
  const _PersonalInfoSection({
    required this.expanded,
    required this.onToggle,
  });

  final bool expanded;
  final VoidCallback onToggle;

  static const _items = [
    _InfoItem(label: 'Full Name', value: 'Rahmat Ullah'),
    _InfoItem(label: 'Phone', value: '017XXXXXXXX'),
    _InfoItem(label: 'District', value: 'Dhaka'),
    _InfoItem(label: 'Thana', value: 'Mirpur 12'),
    _InfoItem(label: 'Last Donation', value: '45 days ago'),
    _InfoItem(label: 'Facebook ID', value: '@rahmat.ullah'),
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: const Icon(Icons.expand_more,
                        size: 18, color: AppColors.textMuted),
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
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: List.generate(_items.length, (i) {
                  final item = _items[i];
                  return Container(
                    decoration: BoxDecoration(
                      border: i < _items.length - 1
                          ? const Border(
                              bottom: BorderSide(
                                  color: AppColors.dividerLightest),
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                                    color: AppColors.textMuted),
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
                        const Icon(Icons.edit,
                            size: 14, color: AppColors.textDisabled),
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

class _ToggleSwitch extends StatelessWidget {
  const _ToggleSwitch({required this.value, required this.onChange});

  final bool value;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : AppColors.divider,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value ? 22 : 2,
              top: 2,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final toggles = <_ToggleRow>[
      _ToggleRow(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
        value: state.notifications,
        onChange: () => bloc.add(const ProfileEvent.notificationsToggled()),
      ),
      _ToggleRow(
        icon: Icons.dark_mode_outlined,
        label: 'Dark Mode',
        value: state.darkMode,
        onChange: () => bloc.add(const ProfileEvent.darkModeToggled()),
      ),
      _ToggleRow(
        icon: Icons.volume_up_outlined,
        label: 'Quiet Hours (10pm–8am)',
        value: state.quietHours,
        onChange: () => bloc.add(const ProfileEvent.quietHoursToggled()),
      ),
    ];

    final navigators = <_NavRow>[
      const _NavRow(icon: Icons.lock_outline, label: 'Privacy Settings'),
      const _NavRow(icon: Icons.language, label: 'App Language (English)'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              '⚙️ Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                for (final t in toggles)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(t.icon, size: 18, color: AppColors.textTertiary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            t.label,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        _ToggleSwitch(value: t.value, onChange: t.onChange),
                      ],
                    ),
                  ),
                for (final n in navigators)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(n.icon, size: 18, color: AppColors.textTertiary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            n.label,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right,
                            size: 16, color: AppColors.textDisabled),
                      ],
                    ),
                  ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, size: 18, color: AppColors.primary),
                        SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChange,
  });

  final IconData icon;
  final String label;
  final bool value;
  final VoidCallback onChange;
}

class _NavRow {
  const _NavRow({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
