import 'package:flutter/material.dart';

import '../../../../../domain/models/chat_contact.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/typing_dots.dart';

class ChatTypingRow extends StatelessWidget {
  const ChatTypingRow({super.key, required this.contact});

  final ChatContact contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Avatar(
          initials: contact.initials,
          colorHex: contact.avatarColor,
          imageUrl: contact.photoUrl,
          size: 28,
        ),
        const SizedBox(width: 8),
        const TypingBubble(),
      ],
    );
  }
}
