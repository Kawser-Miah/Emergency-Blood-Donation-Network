import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_request_event.dart';
import 'create_request_state.dart';

class CreateRequestBloc
    extends Bloc<CreateRequestEvent, CreateRequestState> {
  CreateRequestBloc() : super(CreateRequestState.initial()) {
    on<CreateRequestEvent>((event, emit) {
      event.when(
        patientNameChanged: (v) => emit(state.copyWith(patientName: v)),
        bloodGroupChanged: (v) => emit(state.copyWith(bloodGroup: v)),
        unitsIncremented: () =>
            emit(state.copyWith(units: math.min(10, state.units + 1))),
        unitsDecremented: () =>
            emit(state.copyWith(units: math.max(1, state.units - 1))),
        hospitalChanged: (v) => emit(state.copyWith(hospital: v)),
        addressChanged: (v) => emit(state.copyWith(address: v)),
        urgencyChanged: (v) => emit(state.copyWith(urgency: v)),
        needByChanged: (v) => emit(state.copyWith(needBy: v)),
        contactChanged: (v) => emit(state.copyWith(contact: v)),
        notesChanged: (v) => emit(state.copyWith(notes: v)),
        shareFacebookToggled: () =>
            emit(state.copyWith(shareFacebook: !state.shareFacebook)),
        confirmed1Toggled: () =>
            emit(state.copyWith(confirmed1: !state.confirmed1)),
        confirmed2Toggled: () =>
            emit(state.copyWith(confirmed2: !state.confirmed2)),
      );
    });
  }
}
