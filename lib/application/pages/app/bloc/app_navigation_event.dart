import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/chat_contact.dart';
import '../../../../domain/models/screen.dart';

part 'app_navigation_event.freezed.dart';

@freezed
class AppNavigationEvent with _$AppNavigationEvent {
  const factory AppNavigationEvent.navigated(AppScreen screen, {ChatContact? contact}) =
      _Navigated;
}
