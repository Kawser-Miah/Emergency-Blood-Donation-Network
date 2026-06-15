import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_event.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors.dart';
// import '../bloc/profile_bloc.dart';
// import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({super.key, required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    // Toggles — commented out until feature is ready
    // final bloc = context.read<ProfileBloc>();
    // final toggles = <_ToggleRow>[
    //   _ToggleRow(
    //     icon: Icons.notifications_outlined,
    //     label: 'Notifications',
    //     value: state.notifications,
    //     onChange: () => bloc.add(const ProfileEvent.notificationsToggled()),
    //   ),
    //   _ToggleRow(
    //     icon: Icons.dark_mode_outlined,
    //     label: 'Dark Mode',
    //     value: state.darkMode,
    //     onChange: () => bloc.add(const ProfileEvent.darkModeToggled()),
    //   ),
    //   _ToggleRow(
    //     icon: Icons.volume_up_outlined,
    //     label: 'Quiet Hours (10pm–8am)',
    //     value: state.quietHours,
    //     onChange: () => bloc.add(const ProfileEvent.quietHoursToggled()),
    //   ),
    // ];

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
                // Toggle rows (Notifications, Dark Mode, Quiet Hours) — commented out
                // for (final t in toggles) ...

                _NavItem(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Privacy Policy',
                  onTap: () => context.push(PAGES.privacyPolicy.screenPath),
                ),
                _NavItem(
                  icon: Icons.lock_outline,
                  label: 'Privacy Settings',
                  onTap: () {},
                ),
                _NavItem(
                  icon: Icons.language,
                  label: 'App Language (English)',
                  onTap: () {},
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.dividerLightest),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textTertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
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
    );
  }
}

// Toggle widgets kept for future use
// class _ToggleSwitch ...
// class _ToggleRow ...
