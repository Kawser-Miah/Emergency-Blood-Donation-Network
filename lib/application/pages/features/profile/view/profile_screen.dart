import 'package:blood_setu/application/core/widgets/sparkle_loading_overlay.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:blood_setu/application/pages/features/sign_in/bloc/sign_in_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/donation_usecase.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_add_donation_sheet.dart';
import '../widgets/profile_badges_section.dart';
import '../widgets/profile_cover_photo.dart';
import '../widgets/profile_donation_history.dart';
import '../widgets/profile_name_and_group.dart';
import '../widgets/profile_personal_info.dart';
import '../widgets/profile_quick_actions.dart';
import '../widgets/profile_settings_section.dart';
import '../widgets/profile_stats_card.dart';

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

  void _openAddDonation(BuildContext context, ProfileState state) {
    final bloc = context.read<ProfileBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: AddDonationSheet(bloodGroup: state.profile!.bloodGroup ?? ''),
      ),
    );
  }

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
              floatingActionButton: state.profile == null
                  ? null
                  : FloatingActionButton.extended(
                      onPressed: () => _openAddDonation(context, state),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text(
                        'Record Donation',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 96),
                    child: Column(
                      children: [
                        ProfileCoverPhoto(profile: state.profile),
                        const SizedBox(height: 72),
                        ProfileNameAndGroup(profile: state.profile),
                        const SizedBox(height: 20),
                        ProfileQuickActions(profile: state.profile),
                        const SizedBox(height: 16),
                        ProfileStatsCard(profile: state.profile),
                        const SizedBox(height: 16),
                        ProfileBadgesSection(
                          totalDonations: state.profile?.totalDonations ?? 0,
                        ),
                        const SizedBox(height: 16),
                        ProfileDonationHistorySection(
                          history: state.donationHistory,
                          isLoading: state.isLoading,
                        ),
                        const SizedBox(height: 16),
                        ProfilePersonalInfoSection(
                          profile: state.profile,
                          expanded: state.infoExpanded,
                          onToggle: () => context.read<ProfileBloc>().add(
                            const ProfileEvent.infoExpandedToggled(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ProfileSettingsSection(state: state),
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
