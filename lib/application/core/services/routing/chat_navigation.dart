import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/domain/models/chat_contact.dart';
import 'package:blood_setu/domain/models/chat_screen_args.dart';
import 'package:blood_setu/domain/models/chat_source.dart';

const _kAvatarColors = [
  '#1E88E5',
  '#43A047',
  '#E53935',
  '#FB8C00',
  '#9C27B0',
  '#00ACC1',
  '#F06292',
  '#26A69A',
];

String chatAvatarColor(String uid) =>
    _kAvatarColors[uid.hashCode.abs() % _kAvatarColors.length];

String chatInitials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts[0][0].toUpperCase();
  return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
}

/// Pushes the chat screen.  Pass [conversationId] when the conversation already
/// exists (e.g. from the chat list); leave it null to let the ChatBloc call
/// getOrCreateConversation on open.
void navigateToChat({
  required String currentUid,
  required String otherUid,
  required String otherName,
  required String otherBloodGroup,
  required ChatSource chatSource,
  String? conversationId,
}) {
  AppRouter.router.push(
    PAGES.chat.screenPath,
    extra: ChatScreenArgs(
      contact: ChatContact(
        id: otherUid,
        name: otherName,
        bloodGroup: otherBloodGroup,
        initials: chatInitials(otherName),
        avatarColor: chatAvatarColor(otherUid),
        online: false,
      ),
      currentUid: currentUid,
      conversationId: conversationId,
      otherUid: otherUid,
      chatSource: chatSource,
    ),
  );
}
