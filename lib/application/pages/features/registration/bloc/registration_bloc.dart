import 'package:flutter_bloc/flutter_bloc.dart';

import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState.initial()) {
    on<RegistrationEvent>((event, emit) {
      event.when(
        fullNameChanged: (value) => emit(state.copyWith(fullName: value)),
        phoneChanged: (value) => emit(state.copyWith(phone: value)),
        bloodGroupChanged: (value) => emit(state.copyWith(bloodGroup: value)),
        ageChanged: (value) => emit(state.copyWith(age: value)),
        lastDonationChanged: (value) => emit(state.copyWith(lastDonation: value)),
        districtChanged: (value) =>
            emit(state.copyWith(district: value, thana: '')),
        thanaChanged: (value) => emit(state.copyWith(thana: value)),
        fbIdChanged: (value) => emit(state.copyWith(fbId: value)),
        confirmedToggled: () => emit(state.copyWith(confirmed: !state.confirmed)),
        nextStep: () {
          if (state.step < 2) emit(state.copyWith(step: state.step + 1));
        },
        previousStep: () {
          if (state.step > 1) emit(state.copyWith(step: state.step - 1));
        },
      );
    });
  }
}
