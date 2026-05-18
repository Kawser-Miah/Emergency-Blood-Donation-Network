import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_request_state.freezed.dart';

@freezed
class CreateRequestState with _$CreateRequestState {
  const factory CreateRequestState({
    @Default('') String patientName,
    @Default('') String bloodGroup,
    @Default(1) int units,
    @Default('') String hospital,
    @Default('') String address,
    @Default('URGENT') String urgency,
    @Default('') String needBy,
    @Default('01700000000') String contact,
    @Default('') String notes,
    @Default(false) bool shareFacebook,
    @Default(false) bool confirmed1,
    @Default(false) bool confirmed2,
  }) = _CreateRequestState;

  factory CreateRequestState.initial() => const CreateRequestState();
}
