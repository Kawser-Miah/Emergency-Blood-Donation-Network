import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/blood_request.dart';
import '../../../../../domain/models/nearby_donor.dart';
import '../../../../../domain/models/user_profile_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool showSidebar,
    @Default(false) bool sosPressed,
    UserProfileModel? profile,
    @Default(<NearbyDonor>[]) List<NearbyDonor> nearbyDonors,
    @Default(true) bool isLoadingNearby,
    String? nearbyError,
    double? userLat,
    double? userLng,
    @Default(<BloodRequest>[]) List<BloodRequest> bloodRequests,
    @Default(true) bool isLoadingRequests,
    @Default(false) bool imComingSuccess,
    @Default(false) bool imComingFailed,
    @Default(<String>[]) List<String> interestedRequestIds,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState();
}
