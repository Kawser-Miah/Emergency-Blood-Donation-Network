import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blood_requests_state.freezed.dart';

@freezed
class BloodRequestsState with _$BloodRequestsState {
  const BloodRequestsState._();

  const factory BloodRequestsState({
    @Default(<BloodRequest>[]) List<BloodRequest> requests,
    @Default(<BloodRequest>[]) List<BloodRequest> filtered,
    @Default(true) bool hasMore,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default('') String search,
    @Default('All') String selectedBloodGroup,
    @Default('All') String selectedUrgency,
    @Default(false) bool showFilters,
    String? error,
    double? userLat,
    double? userLng,
  }) = _BloodRequestsState;

  factory BloodRequestsState.initial() => const BloodRequestsState();

  bool get isInitialLoading => isLoading && requests.isEmpty;
  bool get hasError => error != null && requests.isEmpty;
}
