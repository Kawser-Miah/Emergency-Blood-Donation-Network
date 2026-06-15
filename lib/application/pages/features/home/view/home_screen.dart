import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../domain/models/chat_source.dart';
import '../../../../../domain/models/chat_source_type.dart';
import '../../../../../utils/utils.dart';
import '../../../../core/auth/auth_controller.dart';
import '../../../../core/services/routing/chat_navigation.dart';
import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_active_requests.dart';
import '../widgets/home_nearby_donors.dart';
import '../widgets/home_sidebar.dart';
import '../widgets/home_sos_button.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/home_welcome_card.dart';

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
                    HomeTopBar(
                      onMenu: () => context
                          .read<HomeBloc>()
                          .add(const HomeEvent.sidebarOpened()),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: HomeWelcomeCard(
                                  profile: state.profile),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: HomeSosButton(
                                pressed: state.sosPressed,
                                onPressed: () => context
                                    .read<HomeBloc>()
                                    .add(const HomeEvent.sosPressed()),
                              ),
                            ),
                            const SizedBox(height: 20),
                            HomeNearbyDonors(
                              donors: state.nearbyDonors,
                              isLoading: state.isLoadingNearby,
                              onSeeAll: () => AppRouter.router
                                  .push(PAGES.donors.screenPath),
                            ),
                            const SizedBox(height: 20),
                            HomeActiveRequests(
                              requests: state.bloodRequests,
                              isLoading: state.isLoadingRequests,
                              userLat: state.userLat,
                              userLng: state.userLng,
                              userIsActive:
                                  state.profile?.isActive ?? false,
                              userBloodGroup:
                                  state.profile?.bloodGroup ?? '',
                              interestedRequestIds:
                                  state.interestedRequestIds,
                              onMessage: (req) {
                                final uid =
                                    getIt<AuthController>().user?.uid;
                                if (uid == null) return;
                                navigateToChat(
                                  currentUid: uid,
                                  otherUid: req.uid,
                                  otherName: 'Blood Requester',
                                  otherBloodGroup: req.bloodGroup,
                                  chatSource: ChatSource(
                                    type: ChatSourceType.bloodRequest,
                                    referenceId: req.id,
                                  ),
                                  otherPhotoUrl: null,
                                );
                              },
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
                    onPressed: () => AppRouter.router
                        .push(PAGES.createRequest.screenPath),
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                if (state.showSidebar) const HomeSidebar(),
              ],
            ),
          );
        },
      ),
    );
  }
}
