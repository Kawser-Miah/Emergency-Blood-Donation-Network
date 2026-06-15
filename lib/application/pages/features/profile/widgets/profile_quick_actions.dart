import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class ProfileQuickActions extends StatelessWidget {
  const ProfileQuickActions({super.key, required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _ActionCard(
            icon: Icons.water_drop_outlined,
            label: 'My\nRequests',
            color: AppColors.primary,
            bg: AppColors.primarySurface,
            border: AppColors.primaryBorder,
            onTap: () => context.push(PAGES.myRequests.screenPath),
          ),
          const SizedBox(width: 10),
          _ActionCard(
            icon: Icons.favorite_border,
            label: 'My\nInterests',
            color: AppColors.avatarPurple,
            bg: const Color(0xFFF3E5F5),
            border: const Color(0xFFCE93D8),
            onTap: () => context.push(PAGES.myInterests.screenPath),
          ),
          const SizedBox(width: 10),
          _ActionCard(
            icon: Icons.edit_outlined,
            label: 'Edit\nProfile',
            color: AppColors.info,
            bg: AppColors.infoSurface,
            border: const Color(0xFF90CAF9),
            onTap: () async {
              if (profile == null) return;
              await AppRouter.router.push(
                PAGES.editProfile.screenPath,
                extra: profile,
              );
              if (context.mounted) {
                context.read<ProfileBloc>().add(const ProfileEvent.started());
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
    required this.border,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final Color border;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
