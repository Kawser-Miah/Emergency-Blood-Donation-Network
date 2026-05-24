import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../domain/models/blood_request.dart';
import '../../../../../domain/models/donor.dart';
import '../../../../../widgets/avatar.dart';
import '../../../../../widgets/bottom_nav.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class _UrgencyConfig {
  const _UrgencyConfig({
    required this.color,
    required this.bg,
    required this.emoji,
    required this.label,
  });

  final Color color;
  final Color bg;
  final String emoji;
  final String label;
}

const Map<String, _UrgencyConfig> _urgencyConfig = {
  'CRITICAL': _UrgencyConfig(
    color: AppColors.primary,
    bg: AppColors.primarySurface,
    emoji: '🔴',
    label: 'CRITICAL',
  ),
  'URGENT': _UrgencyConfig(
    color: AppColors.warning,
    bg: AppColors.warningSurface,
    emoji: '🟠',
    label: 'URGENT',
  ),
  'NORMAL': _UrgencyConfig(
    color: AppColors.info,
    bg: AppColors.infoSurface,
    emoji: '🔵',
    label: 'NORMAL',
  ),
};

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  _TopBar(
                    onMenu: () => context
                        .read<HomeBloc>()
                        .add(const HomeEvent.sidebarOpened()),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 96),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: _WelcomeCard(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: _SosButton(
                              pressed: state.sosPressed,
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(const HomeEvent.sosPressed()),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _NearbyDonors(
                            onSeeAll: () {},
                            onMessage: (donor) {}
                                // context.read<AppNavigationBloc>().add(
                                //       AppNavigationEvent.navigated(
                                //         AppScreen.chat,
                                //         contact: ChatContact(
                                //           name: donor.name,
                                //           bloodGroup: donor.bloodGroup,
                                //           id: donor.id,
                                //           initials: donor.initials,
                                //           avatarColor: donor.avatarColor,
                                //           online: donor.online,
                                //         ),
                                //       ),
                                //     ),
                          ),
                          const SizedBox(height: 20),
                          _ActiveRequests(
                            onMessage: (req) {}
                                // context.read<AppNavigationBloc>().add(
                                //       AppNavigationEvent.navigated(
                                //         AppScreen.chat,
                                //         contact: ChatContact(
                                //           name: 'Blood Request',
                                //           bloodGroup: req.bloodGroup,
                                //           id: req.id,
                                //           initials: 'BR',
                                //           avatarColor: '#E53935',
                                //           online: true,
                                //         ),
                                //       ),
                                //     ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: 80,
                child: FloatingActionButton(
                  onPressed: () {},
                      // context.read<AppNavigationBloc>().add(
                      //   const AppNavigationEvent.navigated(
                      //       AppScreen.createRequest),
                      // ),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
              const BottomNav(active: 'home'),
              if (state.showSidebar) const _Sidebar(),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onMenu});

  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 4, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenu,
            icon: const Icon(Icons.menu, size: 22),
            color: AppColors.textSecondary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Blood Connect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, size: 22),
                color: AppColors.textSecondary,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primarySurfaceLight, AppColors.primarySurface],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hello 👋',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textTertiary)),
                  Text('Rahmat Ullah',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gold, AppColors.goldDark],
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  '🏆 Gold',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                _Stat(emoji: '🩸', value: '12', label: 'Donations', color: AppColors.primary),
                _VStat(),
                _Stat(emoji: '❤️', value: '8', label: 'Lives Saved', color: AppColors.success),
                _VStat(),
                _Stat(emoji: '⭐', value: '4.9', label: 'Rating', color: AppColors.warning),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  final String emoji;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textTertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VStat extends StatelessWidget {
  const _VStat();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: AppColors.primaryBorder,
    );
  }
}

class _SosButton extends StatelessWidget {
  const _SosButton({required this.pressed, required this.onPressed});

  final bool pressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryDarker, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.45),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('🚨', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text(
                  'EMERGENCY – NEED BLOOD NOW',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'One tap • Broadcast to all nearby donors',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NearbyDonors extends StatelessWidget {
  const _NearbyDonors({required this.onSeeAll, required this.onMessage});

  final VoidCallback onSeeAll;
  final void Function(Donor) onMessage;

  @override
  Widget build(BuildContext context) {
    final donors = mockDonors.take(5).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby Donors',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: donors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final donor = donors[i];
              return _DonorCard(
                donor: donor,
                onMessage: () => onMessage(donor),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor, required this.onMessage});

  final Donor donor;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    final firstName = donor.name.split(' ').first;
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(
            initials: donor.initials,
            colorHex: donor.avatarColor,
            size: 44,
            online: donor.online,
          ),
          const SizedBox(height: 8),
          Text(
            firstName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              donor.bloodGroup,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, size: 10, color: AppColors.textTertiary),
              const SizedBox(width: 2),
              Text(
                '${donor.distance} km',
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textTertiary),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 10, color: AppColors.warning),
              const SizedBox(width: 2),
              Text(
                donor.rating.toString(),
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.phone, size: 12, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: InkWell(
                  onTap: onMessage,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.chat_bubble_outline,
                        size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveRequests extends StatelessWidget {
  const _ActiveRequests({required this.onMessage});

  final void Function(BloodRequest) onMessage;

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
                'Blood Requests Near You',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final req in mockRequests) ...[
            _RequestCard(request: req, onMessage: () => onMessage(req)),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request, required this.onMessage});

  final BloodRequest request;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    final urg = _urgencyConfig[request.urgency] ?? _urgencyConfig['NORMAL']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: urg.color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: urg.bg,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(urg.emoji, style: const TextStyle(fontSize: 10)),
                    const SizedBox(width: 6),
                    Text(
                      urg.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: urg.color,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                request.timePosted,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.bloodGroup,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      height: 1,
                    ),
                  ),
                  const Text(
                    'Blood Needed',
                    style: TextStyle(
                        fontSize: 10, color: AppColors.textMuted),
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      request.hospital,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on,
                            size: 10, color: AppColors.textTertiary),
                        const SizedBox(width: 2),
                        Text(
                          '${request.distance} km',
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '🩸 ${request.unitsNeeded} units needed',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textTertiary),
              ),
              const SizedBox(width: 12),
              Text(
                '👤 ${request.respondents} donors coming',
                style:
                    const TextStyle(fontSize: 12, color: AppColors.success),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chat_bubble_outline, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Message',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "🤲 I'm Coming",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context
                .read<HomeBloc>()
                .add(const HomeEvent.sidebarClosed()),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 260,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 4, 24, 24),
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
                                  fontSize: 12, color: AppColors.textTertiary),
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
                        // context
                        //     .read<HomeBloc>()
                        //     .add(const HomeEvent.sidebarClosed());
                        // final s = AppScreenX.fromSlug(it.screen);
                        // if (s != null) {
                        //   context.read<AppNavigationBloc>().add(
                        //         AppNavigationEvent.navigated(s),
                        //       );
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.dividerLightest),
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
                        // context.read<AppNavigationBloc>().add(
                        //   const AppNavigationEvent.navigated(AppScreen.signin),
                        // ),
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

class _SidebarItem {
  const _SidebarItem({required this.emoji, required this.label, required this.screen});
  final String emoji;
  final String label;
  final String screen;
}

const _sidebarItems = [
  _SidebarItem(emoji: '🏠', label: 'Home', screen: 'home'),
  _SidebarItem(emoji: '👤', label: 'My Profile', screen: 'profile'),
  _SidebarItem(emoji: '🩸', label: 'My Donations', screen: 'profile'),
  _SidebarItem(emoji: '📋', label: 'My Requests', screen: 'home'),
  _SidebarItem(emoji: '🔔', label: 'Notifications', screen: 'home'),
  _SidebarItem(emoji: '⚙️', label: 'Settings', screen: 'profile'),
];
