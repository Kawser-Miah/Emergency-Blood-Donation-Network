import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/registration_header_widget.dart';
import '../../../../core/widgets/registration_progress_widget.dart';
import '../../../../core/widgets/sparkle_loading_overlay.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import '../widgets/registration_step1.dart';
import '../widgets/registration_step2.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key, this.initialProfile});

  final UserProfileModel? initialProfile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => initialProfile != null
          ? RegistrationBloc.edit(
              getIt<RegistrationUserUseCase>(),
              initialProfile!,
            )
          : getIt<RegistrationBloc>(),
      child: _RegistrationView(isEditMode: initialProfile != null),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  const _RegistrationView({required this.isEditMode});

  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == RegistrationStatus.failure) {
          Utils.showSnackBar(
            context,
            content: state.errorMessage.isNotEmpty
                ? state.errorMessage
                : isEditMode
                    ? 'Update failed. Please try again.'
                    : 'Registration failed. Please try again.',
            color: Colors.red.shade600,
          );
        } else if (state.status == RegistrationStatus.success) {
          if (isEditMode) {
            Navigator.of(context).pop();
          }
          Utils.showSnackBar(
            context,
            content: isEditMode
                ? 'Profile updated successfully!'
                : 'Registration successful!',
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == RegistrationStatus.loading;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  RegistrationHeaderWidget(
                    title:
                        isEditMode ? 'Edit Profile' : 'Complete Your Profile',
                    subtitle: isEditMode
                        ? 'Update your information below'
                        : 'This helps us match you with blood seekers',
                    onBack:
                        isEditMode ? () => Navigator.of(context).pop() : null,
                  ),
                  RegistrationProgressWidget(
                    step: state.step,
                    onStepTap: (_) => context.read<RegistrationBloc>().add(
                          const RegistrationEvent.previousStep(),
                        ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      child: state.step == 1
                          ? RegistrationStep1(state: state)
                          : RegistrationStep2(
                              state: state, isEditMode: isEditMode),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    border: Border(top: BorderSide(color: AppColors.divider)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (state.step == 1) {
                                context.read<RegistrationBloc>().add(
                                      const RegistrationEvent.nextStep(),
                                    );
                              } else {
                                context.read<RegistrationBloc>().add(
                                      const RegistrationEvent
                                          .registrationSubmitted(),
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      child: Text(
                        state.step == 1
                            ? 'Continue →'
                            : isEditMode
                                ? 'Save Changes'
                                : 'Complete Registration',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) const SparkleLoadingOverlay(),
            ],
          ),
        );
      },
    );
  }
}
