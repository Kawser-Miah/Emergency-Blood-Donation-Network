import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_list_event.freezed.dart';

@freezed
class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.searchChanged(String value) = _SearchChanged;
}
