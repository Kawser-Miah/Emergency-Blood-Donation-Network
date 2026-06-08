import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../domain/models/blood_request.dart';
import '../../../../../domain/models/nearby_donor.dart';
import '../../../../../domain/models/user_profile_model.dart';
import '../../../../../utils/utils.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/blood_request_card.dart';
import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

const List<String> _avatarColors = [
  '#1E88E5',
  '#43A047',
  '#E53935',
  '#FB8C00',
  '#9C27B0',
  '#00ACC1',
  '#F06292',
  '#26A69A',
];

String _colorFor(String uid) =>
    _avatarColors[uid.hashCode.abs() % _avatarColors.length];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (p, c) => p.imComingSuccess != c.imComingSuccess,
          listener: (context, _) => Utils.showSnackBar(
            context,
            content: "You're registered as coming!",
            color: AppColors.success,
          ),
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (p, c) => p.imComingFailed != c.imComingFailed,
          listener: (context, _) => Utils.showSnackBar(
            context,
            content: 'Failed to register interest. Please try again.',
            color: AppColors.primary,
          ),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  _TopBar(
                    onMenu: () => context.read<HomeBloc>().add(
                      const HomeEvent.sidebarOpened(),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: _WelcomeCard(profile: state.profile),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: _SosButton(
                              pressed: state.sosPressed,
                              onPressed: () => context.read<HomeBloc>().add(
                                const HomeEvent.sosPressed(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _NearbyDonors(
                            donors: state.nearbyDonors,
                            isLoading: state.isLoadingNearby,
                            onSeeAll: () {
                              AppRouter.router.push(PAGES.donors.screenPath);
                            },
                          ),
                          const SizedBox(height: 20),
                          _ActiveRequests(
                            requests: state.bloodRequests,
                            isLoading: state.isLoadingRequests,
                            userLat: state.userLat,
                            userLng: state.userLng,
                            userIsActive: state.profile?.isActive ?? false,
                            onMessage: (req) {},
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
                  onPressed: () {
                    AppRouter.router.push(PAGES.createRequest.screenPath);
                  },
                  // context.read<AppNavigationBloc>().add(
                  //   const AppNavigationEvent.navigated(
                  //       AppScreen.createRequest),
                  // ),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
              if (state.showSidebar) const _Sidebar(),
            ],
          ),
        );
      },
      ),
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
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 4,
        16,
        12,
      ),
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
  const _WelcomeCard({required this.profile});

  final UserProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    final name = profile?.fullName ?? 'Guest';
    final tier = profile?.donorTier ?? '';
    final donations = profile?.totalDonations ?? 0;
    final days = profile?.daysToNextDonation ?? 0;
    final isActive = profile?.isActive ?? false;

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
                children: [
                  const Text(
                    'Hello 👋',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (tier.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.gold, AppColors.goldDark],
                    ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    '🏆 $tier',
                    style: const TextStyle(
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
              children: [
                _Stat(
                  emoji: '🩸',
                  value: '$donations',
                  label: 'Donations',
                  color: AppColors.primary,
                ),
                const _VStat(),
                _Stat(
                  emoji: '⏳',
                  value: '$days',
                  label: 'Days to Donate',
                  color: AppColors.info,
                ),
                const _VStat(),
                _Stat(
                  emoji: isActive ? '🟢' : '🔴',
                  value: isActive ? 'Active' : 'Inactive',
                  label: 'Status',
                  color: isActive ? AppColors.success : AppColors.primary,
                ),
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
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
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
    return Container(width: 1, height: 32, color: AppColors.primaryBorder);
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
  const _NearbyDonors({
    required this.donors,
    required this.isLoading,
    required this.onSeeAll,
  });

  final List<NearbyDonor> donors;
  final bool isLoading;
  final VoidCallback onSeeAll;

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
          height: 200,
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                )
              : donors.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🩸', style: TextStyle(fontSize: 32)),
                      const SizedBox(height: 8),
                      const Text(
                        'No donors found nearby',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      TextButton(
                        onPressed: onSeeAll,
                        child: const Text(
                          'Search wider area',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: donors.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, i) => _DonorCard(donor: donors[i]),
                ),
        ),
      ],
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor});

  final NearbyDonor donor;

  @override
  Widget build(BuildContext context) {
    final firstName = donor.name.split(' ').first;
    final photoUrl = donor.photoUrl;
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
          photoUrl != null && photoUrl.isNotEmpty
              ? CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(photoUrl),
                )
              : Avatar(
                  initials: donor.initials,
                  colorHex: _colorFor(donor.uid),
                  size: 44,
                  online: donor.isActive,
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
              const Icon(
                Icons.location_on,
                size: 10,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 2),
              Text(
                '${donor.distanceKm.toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🩸', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 2),
              Text(
                '${donor.totalDonations} donations',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
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
                  child: const Icon(
                    Icons.phone,
                    size: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    size: 12,
                    color: Colors.white,
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
  const _ActiveRequests({
    required this.requests,
    required this.isLoading,
    required this.onMessage,
    required this.userIsActive,
    this.userLat,
    this.userLng,
  });

  final List<BloodRequest> requests;
  final bool isLoading;
  final void Function(BloodRequest) onMessage;
  final bool userIsActive;
  final double? userLat;
  final double? userLng;

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
                onPressed: () =>
                    AppRouter.router.push(PAGES.bloodRequests.screenPath),
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
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            )
          else if (requests.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🩸', style: TextStyle(fontSize: 32)),
                  const SizedBox(height: 8),
                  const Text(
                    'No active blood requests',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        AppRouter.router.push(PAGES.bloodRequests.screenPath),
                    child: const Text(
                      'See all requests',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            for (final req in requests) ...[
              BloodRequestCard(
                request: req,
                userLat: userLat,
                userLng: userLng,
                onMessage: () => onMessage(req),
                onImComing: userIsActive
                    ? () => context
                        .read<HomeBloc>()
                        .add(HomeEvent.imComing(req.id))
                    : null,
              ),
              const SizedBox(height: 12),
            ],
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
            onTap: () =>
                context.read<HomeBloc>().add(const HomeEvent.sidebarClosed()),
            child: Container(color: Colors.black.withOpacity(0.4)),
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.dividerLightest,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              it.emoji,
                              style: const TextStyle(fontSize: 18),
                            ),
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
              onPressed: () =>
                  context.read<HomeBloc>().add(const HomeEvent.sidebarClosed()),
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
  const _SidebarItem({required this.emoji, required this.label, this.route});
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
