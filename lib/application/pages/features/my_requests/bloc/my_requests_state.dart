import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/models/interested_donor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_requests_state.freezed.dart';

@freezed
class MyRequestsState with _$MyRequestsState {
  const factory MyRequestsState({
    @Default(<BloodRequest>[]) List<BloodRequest> requests,
    @Default(true) bool isLoading,
    String? error,
    @Default(<InterestedDonor>[]) List<InterestedDonor> interestedDonors,
    @Default(false) bool isLoadingDonors,
    String? activeRequestId,
    @Default(false) bool isUpdating,
    String? updateError,
    @Default(false) bool updateSuccess,
    @Default(false) bool deleteSuccess,
    @Default(false) bool deleteFailed,
  }) = _MyRequestsState;

  factory MyRequestsState.initial() => const MyRequestsState();
}
