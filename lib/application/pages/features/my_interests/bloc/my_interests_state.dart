import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_interests_state.freezed.dart';

@freezed
class MyInterestsState with _$MyInterestsState {
  const factory MyInterestsState({
    @Default(<BloodRequest>[]) List<BloodRequest> interests,
    @Default(true) bool isLoading,
    String? error,
    String? withdrawingId,
    @Default(false) bool withdrawSuccess,
    @Default(false) bool withdrawFailed,
  }) = _MyInterestsState;

  factory MyInterestsState.initial() => const MyInterestsState();
}
