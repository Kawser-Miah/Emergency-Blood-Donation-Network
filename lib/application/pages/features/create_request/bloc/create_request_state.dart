import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_request_state.freezed.dart';

enum CreateRequestStatus { initial, loading, success, failure }

@freezed
class CreateRequestState with _$CreateRequestState {
  const factory CreateRequestState({
    @Default('') String patientName,
    @Default('') String bloodGroup,
    @Default(1) int units,
    @Default('') String hospital,
    @Default('') String address,
    @Default('URGENT') String urgency,
    DateTime? needBy,
    @Default('') String contact,
    @Default('') String notes,
    @Default(false) bool confirmed1,
    @Default(false) bool confirmed2,
    @Default(false) bool isGpsLoading,
    double? latitude,
    double? longitude,
    @Default(CreateRequestStatus.initial) CreateRequestStatus status,
    @Default('') String errorMessage,
  }) = _CreateRequestState;

  factory CreateRequestState.initial() => const CreateRequestState();
}
