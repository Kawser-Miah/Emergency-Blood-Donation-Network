import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.inputChanged(String value) = _InputChanged;
  const factory ChatEvent.sendRequested(String text) = _SendRequested;
  const factory ChatEvent.attachmentToggled() = _AttachmentToggled;
  const factory ChatEvent.attachmentClosed() = _AttachmentClosed;
  const factory ChatEvent.replyArrived() = _ReplyArrived;
}
