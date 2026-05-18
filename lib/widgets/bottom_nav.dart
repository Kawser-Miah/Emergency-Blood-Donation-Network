import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/core/theme/colors.dart';
import '../application/pages/app/bloc/app_navigation_bloc.dart';
import '../application/pages/app/bloc/app_navigation_event.dart';
import '../domain/models/screen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.active});

  final String active;

  @override
  Widget build(BuildContext context) {
    final items = [
      const _NavItem(id: 'home', icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      const _NavItem(id: 'donors', icon: Icons.people_outline, activeIcon: Icons.people, label: 'Donors'),
      const _NavItem(id: 'chats', icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Messages'),
      const _NavItem(id: 'profile', icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
    ];

    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 64 + bottomInset,
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.divider)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Row(
          children: items.map((item) {
            final isActive = active == item.id;
            return Expanded(
              child: InkWell(
                onTap: () {
                  final screen = AppScreenX.fromSlug(item.id);
                  if (screen != null) {
                    context.read<AppNavigationBloc>().add(
                          AppNavigationEvent.navigated(screen),
                        );
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive ? item.activeIcon : item.icon,
                          size: 22,
                          color: isActive ? AppColors.primary : AppColors.textMuted,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive ? AppColors.primary : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    if (isActive)
                      const Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: 24,
                          height: 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2),
                                topRight: Radius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.id,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final String id;
  final IconData icon;
  final IconData activeIcon;
  final String label;
}
