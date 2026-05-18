import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_summary.freezed.dart';

@freezed
class ChatSummary with _$ChatSummary {
  const factory ChatSummary({
    required String id,
    required String name,
    required String bloodGroup,
    required String lastMessage,
    required String time,
    required int unread,
    required bool online,
    required bool typing,
    required String initials,
    required String avatarColor,
  }) = _ChatSummary;
}
