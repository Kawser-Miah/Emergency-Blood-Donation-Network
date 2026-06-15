import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

String profileInitials(String? name) {
  if (name == null || name.trim().isEmpty) return '?';
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

class ProfileCoverPhoto extends StatelessWidget {
  const ProfileCoverPhoto({super.key, required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final initials = profileInitials(profile?.fullName);
    final topPad = MediaQuery.of(context).padding.top;
    final isActive = profile?.isActive ?? false;
    final bloodGroup = profile?.bloodGroup;

    return SizedBox(
      height: 216 + topPad,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gradient background with wave clip
          Positioned.fill(
            child: ClipPath(
              clipper: _CoverWaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7B0000),
                      AppColors.primaryDark,
                      AppColors.primary,
                      Color(0xFFEF5350),
                    ],
                    stops: [0.0, 0.25, 0.65, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Large decorative water drop — background art
          Positioned(
            top: topPad - 24,
            right: -28,
            child: Icon(
              Icons.water_drop,
              size: 180,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),

          // Decorative circles
          Positioned(
            top: topPad + 30,
            left: 24,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: -36,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: topPad + 8,
            right: 90,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.09),
              ),
            ),
          ),

          // Blood group badge — top left
          if (bloodGroup != null)
            Positioned(
              top: topPad + 14,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.water_drop, size: 13, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      bloodGroup,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Active / Inactive status badge — top right
          Positioned(
            top: topPad + 14,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.green.withValues(alpha: 0.22)
                    : Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? Colors.greenAccent.withValues(alpha: 0.55)
                      : Colors.white.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? Colors.greenAccent : Colors.white54,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: Colors.greenAccent.withValues(alpha: 0.6),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isActive ? 'Active' : 'Inactive',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Avatar — overlaps into the section below
          Positioned(
            bottom: -54,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Soft glow ring
                  Container(
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.22),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.avatarPurple,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.28),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: profile?.photoUrl != null &&
                            profile!.photoUrl!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              profile!.photoUrl!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : Text(
                            initials,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height - 28);
    path.quadraticBezierTo(
      size.width * 0.22, size.height + 8,
      size.width * 0.5, size.height - 16,
    );
    path.quadraticBezierTo(
      size.width * 0.78, size.height - 44,
      size.width, size.height - 12,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_CoverWaveClipper oldClipper) => false;
}
