import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_interests_event.freezed.dart';

@freezed
class MyInterestsEvent with _$MyInterestsEvent {
  const factory MyInterestsEvent.started() = _Started;
  const factory MyInterestsEvent.refreshed() = _Refreshed;
  const factory MyInterestsEvent.withdrawRequested(String requestId) =
      _WithdrawRequested;
}
