import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/routing/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/avatar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class _SidebarItem {
  const _SidebarItem({
    required this.emoji,
    required this.label,
    this.route,
  });

  final String emoji;
  final String label;
  final String? route;
}

const _sidebarItems = [
  _SidebarItem(emoji: '🏠', label: 'Home'),
  _SidebarItem(emoji: '👤', label: 'My Profile', route: '/profile'),
  _SidebarItem(emoji: '📋', label: 'My Requests', route: '/myRequests'),
  _SidebarItem(emoji: '🔔', label: 'Notifications'),
  _SidebarItem(emoji: '⚙️', label: 'Settings'),
];

class HomeSidebar extends StatelessWidget {
  const HomeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context
                .read<HomeBloc>()
                .add(const HomeEvent.sidebarClosed()),
            child: Container(
                color: Colors.black.withValues(alpha: 0.4)),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 260,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.of(context).padding.top + 4,
                24,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Avatar(
                        initials: 'RU',
                        colorHex: '#E53935',
                        size: 52,
                        online: true,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rahmat Ullah',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'O+ Donor • Dhaka',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ..._sidebarItems.map((it) {
                    return InkWell(
                      onTap: () {
                        context.read<HomeBloc>().add(
                          const HomeEvent.sidebarClosed(),
                        );
                        if (it.route != null) {
                          AppRouter.router.push(it.route!);
                        }
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.dividerLightest,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(it.emoji,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 12),
                            Text(
                              it.label,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: const [
                          Text('🚪', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
          ),
          Positioned(
            top: 48,
            left: 260 - 36,
            child: IconButton(
              onPressed: () => context
                  .read<HomeBloc>()
                  .add(const HomeEvent.sidebarClosed()),
              icon: const Icon(Icons.close, size: 20),
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
