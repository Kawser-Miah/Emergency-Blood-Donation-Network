import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_event.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({super.key, required this.state});

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
                  color: Colors.black.withValues(alpha: 0.06),
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
                      context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.started());
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
                      color: Colors.black.withValues(alpha: 0.2),
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
