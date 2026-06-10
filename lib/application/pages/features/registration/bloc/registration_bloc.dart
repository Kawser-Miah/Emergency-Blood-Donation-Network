import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/failures/failures.dart';
import 'package:blood_setu/domain/models/user_profile_model.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/auth/auth_controller.dart';
import 'registration_event.dart';
import 'registration_state.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUserUseCase _registrationUserUseCase;

  RegistrationBloc(this._registrationUserUseCase)
    : super(
        RegistrationState.initial(
          fullName: getIt<AuthController>().user?.displayName ?? '',
        ),
      ) {
    _init();
  }

  RegistrationBloc.edit(this._registrationUserUseCase, UserProfileModel profile)
    : super(RegistrationState.fromProfile(profile)) {
    _init();
  }

  void _init() {
    on<RegistrationEvent>((event, emit) async {
      await event.when(
        // Reset status on every field change so repeated validation taps re-trigger the listener
        fullNameChanged: (value) async => emit(
          state.copyWith(fullName: value, status: RegistrationStatus.initial),
        ),
        genderChanged: (value) async => emit(
          state.copyWith(gender: value, status: RegistrationStatus.initial),
        ),
        phoneChanged: (value) async => emit(
          state.copyWith(phone: value, status: RegistrationStatus.initial),
        ),
        bloodGroupChanged: (value) async => emit(
          state.copyWith(bloodGroup: value, status: RegistrationStatus.initial),
        ),
        ageChanged: (value) async => emit(
          state.copyWith(age: value, status: RegistrationStatus.initial),
        ),
        lastDonationChanged: (value) async =>
            emit(state.copyWith(lastDonation: value)),

        districtChanged: (value) async => emit(
          state.copyWith(
            district: value,
            thana: '',
            status: RegistrationStatus.initial,
          ),
        ),
        thanaChanged: (value) async => emit(
          state.copyWith(thana: value, status: RegistrationStatus.initial),
        ),
        fbIdChanged: (value) async => emit(state.copyWith(fbId: value)),
        confirmedToggled: () async => emit(
          state.copyWith(
            confirmed: !state.confirmed,
            status: RegistrationStatus.initial,
          ),
        ),
        nextStep: () async {
          if (state.step == 1) {
            emit(state.copyWith(status: RegistrationStatus.initial));

            if (state.fullName.trim().isEmpty) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage:
                      'What\'s your name? Please enter your full name.',
                ),
              );
              return;
            }

            if (state.gender.isEmpty) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'Please select your gender.',
                ),
              );
              return;
            }

            if (state.phone.trim().isEmpty) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'We need your phone number to contact you.',
                ),
              );
              return;
            }

            final phone = state.phone.trim();
            if (!RegExp(r'^\d+$').hasMatch(phone) ||
                phone.length != 11 ||
                !phone.startsWith('01')) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'Please enter a valid phone number.',
                ),
              );
              return;
            }

            if (state.bloodGroup.isEmpty) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'Please select your blood group.',
                ),
              );
              return;
            }

            if (state.age.trim().isEmpty) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'Please enter your age.',
                ),
              );
              return;
            }

            final age = int.tryParse(state.age.trim());
            if (age == null || age < 14 || age > 65) {
              emit(
                state.copyWith(
                  status: RegistrationStatus.failure,
                  errorMessage: 'Please enter a valid age.',
                ),
              );
              return;
            }
          }
          if (state.step < 2) {
            emit(
              state.copyWith(
                step: state.step + 1,
                status: RegistrationStatus.initial,
              ),
            );
          }
        },
        previousStep: () async {
          if (state.step > 1) emit(state.copyWith(step: state.step - 1));
        },
        registrationSubmitted: () async {
          emit(state.copyWith(status: RegistrationStatus.initial));

          if (state.district.isEmpty) {
            emit(
              state.copyWith(
                status: RegistrationStatus.failure,
                errorMessage: 'Please select your district.',
              ),
            );
            return;
          }

          if (state.thana.isEmpty) {
            emit(
              state.copyWith(
                status: RegistrationStatus.failure,
                errorMessage: 'Please select your thana.',
              ),
            );
            return;
          }

          if (!state.isEditMode && !state.confirmed) {
            emit(
              state.copyWith(
                status: RegistrationStatus.failure,
                errorMessage: 'Please tick the confirmation box to proceed.',
              ),
            );
            return;
          }

          emit(state.copyWith(status: RegistrationStatus.loading));

          try {
            final auth = getIt<AuthController>();
            final existing = auth.profile;

            // For new registration: seed from lastDonation.
            // If the user provided a past donation date they have donated once
            // before → totalDonations = 1, tier = Bronze.
            // If no date → first-time donor → totalDonations = 0, unranked.
            final hasLastDonation = state.lastDonation != null;

            final newProfile = UserProfileModel(
              userUuid: auth.user?.uid,
              fullName: state.fullName,
              gender: state.gender,
              phone: state.phone,
              bloodGroup: state.bloodGroup,
              age: int.tryParse(state.age.trim()),
              lastDonation: state.lastDonation,
              district: state.district,
              thana: state.thana,
              fbId: state.fbId,
              // Edit mode: preserve the counts managed by DonationRepository.
              isActive: state.isEditMode ? (existing?.isActive ?? true) : true,
              donorTier: state.isEditMode ? (existing?.donorTier ?? '') : '',
              totalDonations: state.isEditMode
                  ? (existing?.totalDonations ?? 0)
                  : 0,
            );

            final result = await _registrationUserUseCase.call(newProfile);

            result.fold(
              (failure) {
                if (failure is GeneralFailure) {
                  emit(
                    state.copyWith(
                      status: RegistrationStatus.failure,
                      errorMessage: failure.message,
                    ),
                  );
                } else {
                  emit(
                    state.copyWith(
                      status: RegistrationStatus.failure,
                      errorMessage:
                          'A database error occurred. Please try again later.',
                    ),
                  );
                }
              },
              (_) {
                if (state.isEditMode) {
                  auth.updateProfile(newProfile);
                  emit(state.copyWith(status: RegistrationStatus.success));
                } else {
                  auth.onProfileCompleted();
                  emit(state.copyWith(status: RegistrationStatus.success));
                }
              },
            );
          } catch (e) {
            emit(
              state.copyWith(
                status: RegistrationStatus.failure,
                errorMessage: e.toString(),
              ),
            );
          }
        },
      );
    });
  }
}
