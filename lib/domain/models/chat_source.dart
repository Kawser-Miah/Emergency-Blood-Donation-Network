import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_source_type.dart';

part 'chat_source.freezed.dart';

@freezed
class ChatSource with _$ChatSource {
  const factory ChatSource({
    required ChatSourceType type,
    String? referenceId,
  }) = _ChatSource;

  factory ChatSource.fromMap(Map<String, dynamic> map) => ChatSource(
        type: ChatSourceType.fromString(map['type'] as String? ?? 'direct'),
        referenceId: map['referenceId'] as String?,
      );
}

extension ChatSourceX on ChatSource {
  Map<String, dynamic> toMap() => {
        'type': type.toJson(),
        if (referenceId != null) 'referenceId': referenceId,
      };
}
