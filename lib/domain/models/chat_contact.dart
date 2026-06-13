import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_contact.freezed.dart';

@freezed
class ChatContact with _$ChatContact {
  const factory ChatContact({
    required String name,
    required String bloodGroup,
    required String id,
    required String initials,
    required String avatarColor,
    required bool online,
    String? photoUrl,
  }) = _ChatContact;
}
