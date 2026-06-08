import 'package:blood_setu/domain/models/my_interest_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_interests_state.freezed.dart';

@freezed
class MyInterestsState with _$MyInterestsState {
  const factory MyInterestsState({
    @Default(<MyInterestEntry>[]) List<MyInterestEntry> interests,
    @Default(true) bool isLoading,
    String? error,
    String? withdrawingId,
    String? markingBloodGivenId,
    @Default(false) bool withdrawSuccess,
    @Default(false) bool withdrawFailed,
    @Default(false) bool bloodGivenSuccess,
    @Default(false) bool bloodGivenFailed,
    @Default(false) bool donationRecordFailed,
  }) = _MyInterestsState;

  factory MyInterestsState.initial() => const MyInterestsState();
}
