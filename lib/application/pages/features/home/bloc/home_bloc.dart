import 'dart:async';

import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/blood_requests_usecase.dart';
import 'package:blood_setu/domain/usecase/location_usecase.dart';
import 'package:blood_setu/domain/usecase/nearby_donors_usecase.dart';
import 'package:blood_setu/domain/usecase/registration_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RegistrationUserUseCase _registrationUserUseCase;
  final LocationUseCase _locationUseCase;
  final NearbyDonorsUseCase _nearbyDonorsUseCase;
  final BloodRequestsUseCase _bloodRequestsUseCase;

  HomeBloc(
    this._registrationUserUseCase,
    this._locationUseCase,
    this._nearbyDonorsUseCase,
    this._bloodRequestsUseCase,
  ) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        started: () async {
          final uid = getIt<AuthController>().user?.uid;
          if (uid == null) return;

          final result = await _registrationUserUseCase.getProfile(uid);
          result.fold(
            (_) {},
            (profile) => emit(state.copyWith(profile: profile)),
          );

          // Fire-and-forget: refresh only GPS coordinates in user_locations.
          unawaited(_locationUseCase.updateGps(uid));

          // Fetch up to 5 nearby donors for the home preview.
          final originResult = await _nearbyDonorsUseCase.getOrigin(uid);
          double lat = 0, lng = 0;
          bool hasOrigin = false;
          originResult.fold(
            (_) => emit(state.copyWith(isLoadingNearby: false)),
            (origin) {
              lat = origin.latitude;
              lng = origin.longitude;
              hasOrigin = true;
              emit(state.copyWith(userLat: lat, userLng: lng));
            },
          );
          if (!hasOrigin) return;

          final donorsResult = await _nearbyDonorsUseCase.call(
            latitude: lat,
            longitude: lng,
            radiusKm: 100,
            excludeUid: uid,
          );
          donorsResult.fold(
            (_) => emit(state.copyWith(isLoadingNearby: false)),
            (donors) {
              final sorted = [...donors]
                ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
              emit(
                state.copyWith(
                  nearbyDonors: sorted.take(5).toList(),
                  isLoadingNearby: false,
                ),
              );
            },
          );

          final requestsResult = await _bloodRequestsUseCase(limit: 5);
          requestsResult.fold(
            (_) => emit(state.copyWith(isLoadingRequests: false)),
            (requests) => emit(
              state.copyWith(
                bloodRequests: requests,
                isLoadingRequests: false,
              ),
            ),
          );
        },
        sidebarOpened: () async => emit(state.copyWith(showSidebar: true)),
        sidebarClosed: () async => emit(state.copyWith(showSidebar: false)),
        sosPressed: () async {
          emit(state.copyWith(sosPressed: true));
          await Future.delayed(const Duration(seconds: 2));
          if (!isClosed) add(const HomeEvent.sosReleased());
        },
        sosReleased: () async => emit(state.copyWith(sosPressed: false)),
      );
    });
  }
}
