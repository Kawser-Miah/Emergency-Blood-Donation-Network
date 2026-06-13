import 'package:blood_setu/domain/models/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.loading() = _Loading;
  const factory ChatState.ready({
    required List<Message> messages,
    @Default('') String input,
    @Default(false) bool showAttachment,
    @Default(false) bool showTyping,
    @Default(false) bool otherOnline,
    DateTime? otherLastSeen,
  }) = _Ready;
  const factory ChatState.error(String message) = _Error;
}
