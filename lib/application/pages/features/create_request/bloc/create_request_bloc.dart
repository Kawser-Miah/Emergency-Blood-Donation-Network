import 'dart:math' as math;

import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/create_blood_request_params.dart';
import 'package:blood_setu/domain/usecase/create_request_usecase.dart';
import 'package:blood_setu/domain/usecase/location_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/failures/failures.dart';
import 'create_request_event.dart';
import 'create_request_state.dart';

@injectable
class CreateRequestBloc
    extends Bloc<CreateRequestEvent, CreateRequestState> {
  final CreateRequestUseCase _createRequestUseCase;
  final LocationUseCase _locationUseCase;

  CreateRequestBloc(
    this._createRequestUseCase,
    this._locationUseCase,
  ) : super(CreateRequestState.initial()) {
    on<CreateRequestEvent>((event, emit) async {
      await event.when(
        patientNameChanged: (v) async => emit(
          state.copyWith(patientName: v, status: CreateRequestStatus.initial),
        ),
        bloodGroupChanged: (v) async => emit(
          state.copyWith(bloodGroup: v, status: CreateRequestStatus.initial),
        ),
        unitsIncremented: () async =>
            emit(state.copyWith(units: math.min(10, state.units + 1))),
        unitsDecremented: () async =>
            emit(state.copyWith(units: math.max(1, state.units - 1))),
        hospitalChanged: (v) async => emit(
          state.copyWith(hospital: v, status: CreateRequestStatus.initial),
        ),
        addressChanged: (v) async => emit(state.copyWith(address: v)),
        urgencyChanged: (v) async => emit(
          state.copyWith(urgency: v, status: CreateRequestStatus.initial),
        ),
        needByChanged: (v) async => emit(
          state.copyWith(needBy: v, status: CreateRequestStatus.initial),
        ),
        contactChanged: (v) async => emit(
          state.copyWith(contact: v, status: CreateRequestStatus.initial),
        ),
        notesChanged: (v) async => emit(state.copyWith(notes: v)),
        confirmed1Toggled: () async => emit(
          state.copyWith(
            confirmed1: !state.confirmed1,
            status: CreateRequestStatus.initial,
          ),
        ),
        confirmed2Toggled: () async => emit(
          state.copyWith(
            confirmed2: !state.confirmed2,
            status: CreateRequestStatus.initial,
          ),
        ),
        mapLocationPicked: (lat, lng, address) async => emit(state.copyWith(
          address: address,
          latitude: lat,
          longitude: lng,
          status: CreateRequestStatus.initial,
        )),
        gpsLocationRequested: () async {
          emit(state.copyWith(isGpsLoading: true));
          final result = await _locationUseCase.getAddressData();
          result.fold(
            (failure) {
              final msg = _messageOf(failure, 'Could not fetch GPS location.');
              emit(state.copyWith(
                isGpsLoading: false,
                status: CreateRequestStatus.failure,
                errorMessage: msg,
              ));
            },
            (data) => emit(state.copyWith(
              isGpsLoading: false,
              address: data.address,
              latitude: data.latitude,
              longitude: data.longitude,
              status: CreateRequestStatus.initial,
            )),
          );
        },
        requestSubmitted: () async {
          emit(state.copyWith(status: CreateRequestStatus.initial));

          if (state.patientName.trim().isEmpty) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please enter the patient\'s name.',
            ));
            return;
          }

          if (state.bloodGroup.isEmpty) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please select the blood group needed.',
            ));
            return;
          }

          if (state.hospital.trim().isEmpty) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please enter the hospital or clinic name.',
            ));
            return;
          }

          if (state.needBy == null) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please select when the blood is needed.',
            ));
            return;
          }

          if (!state.needBy!.isAfter(DateTime.now())) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Need-by date must be a future date and time.',
            ));
            return;
          }

          if (state.contact.trim().isEmpty) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please enter a contact number.',
            ));
            return;
          }

          final contact = state.contact.trim();
          if (!RegExp(r'^\d+$').hasMatch(contact) ||
              contact.length != 11 ||
              !contact.startsWith('01')) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage:
                  'Please enter a valid BD phone number (e.g. 01XXXXXXXXX).',
            ));
            return;
          }

          if (!state.confirmed1) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'Please confirm this is a genuine blood request.',
            ));
            return;
          }

          if (!state.confirmed2) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage:
                  'Please confirm you have permission to receive blood for this patient.',
            ));
            return;
          }

          final uid = getIt<AuthController>().user?.uid;
          if (uid == null) {
            emit(state.copyWith(
              status: CreateRequestStatus.failure,
              errorMessage: 'You must be signed in to post a request.',
            ));
            return;
          }

          emit(state.copyWith(status: CreateRequestStatus.loading));

          final result = await _createRequestUseCase.execute(
            CreateBloodRequestParams(
              uid: uid,
              patientName: state.patientName.trim(),
              bloodGroup: state.bloodGroup,
              units: state.units,
              hospital: state.hospital.trim(),
              address: state.address.trim(),
              urgency: state.urgency,
              needBy: state.needBy!,
              contact: contact,
              notes: state.notes.trim(),
              latitude: state.latitude,
              longitude: state.longitude,
            ),
          );

          result.fold(
            (failure) {
              final msg = _messageOf(
                failure, 'Failed to post blood request. Please try again.');
              emit(state.copyWith(
                status: CreateRequestStatus.failure,
                errorMessage: msg,
              ));
            },
            (_) => emit(state.copyWith(status: CreateRequestStatus.success)),
          );
        },
      );
    });
  }

  static String _messageOf(Failure failure, String fallback) {
    if (failure is GeneralFailure) return failure.message;
    if (failure is UnexpectedFailure) return failure.message;
    return fallback;
  }
}
