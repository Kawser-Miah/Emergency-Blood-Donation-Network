import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/core/widgets/sparkle_loading_overlay.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_event.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/usecase/donation_usecase.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

// ─── Badge definitions ────────────────────────────────────────────────────────

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

// ─── Helper utils ─────────────────────────────────────────────────────────────

String _initials(String? name) {
  if (name == null || name.trim().isEmpty) return '?';
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

String _lastDonatedLabel(DateTime? lastDonation) {
  if (lastDonation == null) return '—';
  final days = DateTime.now().difference(lastDonation).inDays;
  if (days == 0) return 'Today';
  if (days == 1) return '1d ago';
  return '${days}d ago';
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileBloc(
            getIt<DonationUseCase>(),
            getIt<RegistrationUserUseCase>(),
          )..add(const ProfileEvent.started()),
        ),
        BlocProvider(create: (_) => getIt<SignInBloc>()),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, signInState) {
        signInState.whenOrNull(
          signOutSuccess: () => Utils.showSnackBar(
            context,
            content: 'You have been successfully logged out.',
            color: Colors.green,
          ),
          failure: (message) =>
              Utils.showSnackBar(context, content: message, color: Colors.red),
        );
      },
      builder: (context, signInState) {
        final isSigningOut = signInState is LoadingSignInState;
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
                        _CoverPhoto(
                          profile: state.profile,
                          onEdit: state.profile == null
                              ? null
                              : () async {
                                  await AppRouter.router.push(
                                    PAGES.editProfile.screenPath,
                                    extra: state.profile,
                                  );
                                  if (context.mounted) {
                                    context.read<ProfileBloc>().add(
                                      const ProfileEvent.started(),
                                    );
                                  }
                                },
                        ),
                        const SizedBox(height: 64),
                        _NameAndGroup(profile: state.profile),
                        const SizedBox(height: 16),
                        _StatsCard(profile: state.profile),
                        const SizedBox(height: 16),
                        _BadgesSection(
                          totalDonations: state.profile?.totalDonations ?? 0,
                        ),
                        const SizedBox(height: 16),
                        _DonationHistorySection(
                          history: state.donationHistory,
                          isLoading: state.isLoading,
                        ),
                        const SizedBox(height: 16),
                        _PersonalInfoSection(
                          profile: state.profile,
                          expanded: state.infoExpanded,
                          onToggle: () => context.read<ProfileBloc>().add(
                            const ProfileEvent.infoExpandedToggled(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SettingsSection(state: state),
                      ],
                    ),
                  ),
                  if (isSigningOut || state.isLoading)
                    const SparkleLoadingOverlay(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ─── Cover photo + avatar ─────────────────────────────────────────────────────

class _CoverPhoto extends StatelessWidget {
  const _CoverPhoto({required this.profile, this.onEdit});

  final UserProfileModel? profile;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(profile?.fullName);
    return SizedBox(
      height: 200 + MediaQuery.of(context).padding.top,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
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
                      child:
                          profile?.photoUrl != null &&
                              profile!.photoUrl!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                profile!.photoUrl!,
                                fit: BoxFit.cover,
                                width: 96,
                                height: 96,
                              ),
                            )
                          : Text(
                              initials,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
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

// ─── Name + blood group chip ──────────────────────────────────────────────────

class _NameAndGroup extends StatelessWidget {
  const _NameAndGroup({required this.profile});

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

// ─── Stats card ───────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.profile});

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

// ─── Badges ───────────────────────────────────────────────────────────────────

class _BadgesSection extends StatelessWidget {
  const _BadgesSection({required this.totalDonations});

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
                color: def.color.withOpacity(0.13),
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

// ─── Donation history ─────────────────────────────────────────────────────────

class _DonationHistorySection extends StatelessWidget {
  const _DonationHistorySection({
    required this.history,
    required this.isLoading,
  });

  final List<DonationHistoryEntry> history;
  final bool isLoading;

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
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            )
          else if (history.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
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
              child: const Center(
                child: Text(
                  'No donations recorded yet.',
                  style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
                ),
              ),
            )
          else
            for (final d in history.take(4)) ...[
              _DonationRow(entry: d),
              const SizedBox(height: 8),
            ],
        ],
      ),
    );
  }
}

class _DonationRow extends StatelessWidget {
  const _DonationRow({required this.entry});

  final DonationHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  entry.hospital,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${DateFormat('dd MMM yyyy').format(entry.date)} • ${entry.bloodGroup}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.successSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '✓ ${entry.status}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Personal info ────────────────────────────────────────────────────────────

class _PersonalInfoSection extends StatelessWidget {
  const _PersonalInfoSection({
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
    final lastDonation = p?.lastDonation != null
        ? _lastDonatedLabel(p!.lastDonation)
        : '—';

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
                    color: Colors.black.withOpacity(0.06),
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

// ─── Settings ─────────────────────────────────────────────────────────────────

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
                        bottom: BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
                        bottom: BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.textDisabled,
                        ),
                      ],
                    ),
                  ),
                InkWell(
                  onTap: () async {
                    final profile = context.read<ProfileBloc>().state.profile;
                    if (profile == null) return;
                    await AppRouter.router.push(
                      PAGES.editProfile.screenPath,
                      extra: profile,
                    );
                    if (context.mounted) {
                      context.read<ProfileBloc>().add(
                        const ProfileEvent.started(),
                      );
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.textDisabled,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context.push(PAGES.myInterests.screenPath),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.dividerLightest),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'My Interests',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.textDisabled,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final confirmed = await Utils.showConfirmDialog(
                      context,
                      title: 'Logout',
                      message: 'Are you sure you want to logout?',
                      confirmLabel: 'Logout',
                    );
                    if (confirmed && context.mounted) {
                      context.read<SignInBloc>().add(SignInEvent.signOut());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
