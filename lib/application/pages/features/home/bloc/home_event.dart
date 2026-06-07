import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.sidebarOpened() = _SidebarOpened;
  const factory HomeEvent.sidebarClosed() = _SidebarClosed;
  const factory HomeEvent.sosPressed() = _SosPressed;
  const factory HomeEvent.sosReleased() = _SosReleased;
  const factory HomeEvent.imComing(String requestId) = _ImComing;
}
