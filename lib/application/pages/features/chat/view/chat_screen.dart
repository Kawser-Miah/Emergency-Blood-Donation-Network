import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../di/di.dart';
import '../../../../../domain/models/chat_contact.dart';
import '../../../../../domain/models/chat_screen_args.dart';
import '../../../../../domain/models/message.dart';
import '../../../../../domain/models/message_status.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/typing_dots.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

const List<String> _quickReplies = [
  "I'm coming",
  "Need 30 min",
  "Call me",
  "On the way 🚗",
];

String _formatLastSeen(DateTime? lastSeen) {
  if (lastSeen == null) return 'Last seen recently';
  final diff = DateTime.now().difference(lastSeen);
  if (diff.inSeconds < 60) return 'Last seen just now';
  if (diff.inMinutes < 60) {
    final m = diff.inMinutes;
    return 'Last seen $m min ago';
  }
  if (diff.inHours < 24) {
    final h = lastSeen.hour == 0
        ? 12
        : (lastSeen.hour > 12 ? lastSeen.hour - 12 : lastSeen.hour);
    final ampm = lastSeen.hour >= 12 ? 'PM' : 'AM';
    final mm = lastSeen.minute.toString().padLeft(2, '0');
    return 'Last seen today at ${h.toString().padLeft(2, '0')}:$mm $ampm';
  }
  if (diff.inDays == 1) return 'Last seen yesterday';
  if (diff.inDays < 7) return 'Last seen ${diff.inDays} days ago';
  return 'Last seen a while ago';
}

String _formatDateLabel(DateTime dt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final msgDay = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(msgDay).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return weekdays[dt.weekday - 1];
  }
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[dt.month - 1]} ${dt.day}';
}

String _formatTime(DateTime dt) {
  final h = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
  final ampm = dt.hour >= 12 ? 'PM' : 'AM';
  final mm = dt.minute.toString().padLeft(2, '0');
  return '${h.toString().padLeft(2, '0')}:$mm $ampm';
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.args});

  final ChatScreenArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<ChatBloc>();
        if (args.conversationId != null) {
          bloc.add(ChatEvent.watchStarted(
            conversationId: args.conversationId!,
            currentUid: args.currentUid,
            otherUid: args.otherUid,
          ));
        } else {
          bloc.add(ChatEvent.openRequested(
            currentUid: args.currentUid,
            otherUid: args.otherUid,
            chatSource: args.chatSource,
          ));
        }
        return bloc;
      },
      child: _ChatView(contact: args.contact, currentUid: args.currentUid),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.contact, required this.currentUid});

  final ChatContact contact;
  final String currentUid;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (prev, next) {
        final prevLen =
            prev.maybeMap(ready: (s) => s.messages.length, orElse: () => 0);
        final nextLen =
            next.maybeMap(ready: (s) => s.messages.length, orElse: () => 0);
        return nextLen > prevLen;
      },
      listener: (_, _) => _scrollToEnd(),
      builder: (context, state) => state.when(
        loading: () => _loadingScaffold(),
        error: (msg) => _errorScaffold(msg),
        ready: (messages, input, showAttachment, showTyping, otherOnline,
            otherLastSeen) {
          if (_inputController.text != input) {
            _inputController.value = TextEditingValue(
              text: input,
              selection: TextSelection.collapsed(offset: input.length),
            );
          }
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Stack(
              children: [
                Column(
                  children: [
                    _AppBar(
                      contact: widget.contact,
                      online: otherOnline,
                      lastSeen: otherLastSeen,
                    ),
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        padding:
                            const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        children: () {
                          final items = <Widget>[];
                          String? lastLabel;
                          for (final msg in messages) {
                            final label = _formatDateLabel(msg.timestamp);
                            if (label != lastLabel) {
                              if (lastLabel != null) {
                                items.add(const SizedBox(height: 8));
                              }
                              items.add(_DateSeparator(label: label));
                              items.add(const SizedBox(height: 16));
                              lastLabel = label;
                            }
                            items.add(_Bubble(
                              message: msg,
                              contact: widget.contact,
                              currentUid: widget.currentUid,
                            ));
                            items.add(const SizedBox(height: 8));
                          }
                          if (showTyping) {
                            items.add(_TypingRow(contact: widget.contact));
                          }
                          return items;
                        }(),
                      ),
                    ),
                    _QuickReplies(
                      onTap: (text) => context
                          .read<ChatBloc>()
                          .add(ChatEvent.messageSent(text)),
                    ),
                    _InputBar(
                      controller: _inputController,
                      input: input,
                      onChanged: (v) => context
                          .read<ChatBloc>()
                          .add(ChatEvent.inputChanged(v)),
                      onSend: () => context
                          .read<ChatBloc>()
                          .add(ChatEvent.messageSent(input)),
                      onAttach: () => context
                          .read<ChatBloc>()
                          .add(const ChatEvent.attachmentToggled()),
                    ),
                  ],
                ),
                if (showAttachment) const _AttachmentSheet(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _loadingScaffold() => Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            _AppBar(contact: widget.contact),
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      );

  Widget _errorScaffold(String msg) => Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            _AppBar(contact: widget.contact),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textTertiary),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.contact, this.online = false, this.lastSeen});

  final ChatContact contact;
  final bool online;
  final DateTime? lastSeen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
          12, MediaQuery.of(context).padding.top + 4, 12, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, size: 22),
            color: AppColors.textSecondary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          Avatar(
            initials: contact.initials,
            colorHex: contact.avatarColor,
            imageUrl: contact.photoUrl,
            size: 38,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        contact.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (contact.bloodGroup.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          contact.bloodGroup,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (online) ...[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Online now',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.success),
                      ),
                    ] else
                      Text(
                        _formatLastSeen(lastSeen),
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textMuted),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, size: 20),
            color: AppColors.textSecondary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _DateSeparator extends StatelessWidget {
  const _DateSeparator({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.contact,
    required this.currentUid,
  });

  final Message message;
  final ChatContact contact;
  final String currentUid;

  @override
  Widget build(BuildContext context) {
    final isSent = message.senderId == currentUid;
    final isRead = message.status == MessageStatus.read ||
        message.readBy.length > 1;
    final isSending = message.status == MessageStatus.sending;

    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // if (!isSent)
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8),
        //     child: Avatar(
        //       initials: contact.initials,
        //       colorHex: contact.avatarColor,
        //       size: 28,
        //     ),
        //   ),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Column(
              crossAxisAlignment: isSent
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSent
                        ? AppColors.primary
                        : AppColors.dividerLight,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isSent ? 16 : 4),
                      bottomRight: Radius.circular(isSent ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isSent ? Colors.white : AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(message.timestamp),
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted),
                    ),
                    if (isSent) ...[
                      const SizedBox(width: 4),
                      isSending
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: AppColors.textMuted,
                            )
                          : Text(
                              '✓✓',
                              style: TextStyle(
                                fontSize: 10,
                                color: isRead
                                    ? AppColors.info
                                    : AppColors.textMuted,
                              ),
                            ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TypingRow extends StatelessWidget {
  const _TypingRow({required this.contact});

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

class _QuickReplies extends StatelessWidget {
  const _QuickReplies({required this.onTap});

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        itemCount: _quickReplies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final r = _quickReplies[i];
          return GestureDetector(
            onTap: () => onTap(r),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Text(
                r,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.input,
    required this.onChanged,
    required this.onSend,
    required this.onAttach,
  });

  final TextEditingController controller;
  final String input;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    final hasText = input.trim().isNotEmpty;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.dividerLighter)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onAttach,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.dividerLightest,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.attach_file,
                  size: 18, color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              constraints:
                  const BoxConstraints(minHeight: 44, maxHeight: 80),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      maxLines: null,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Type a message...',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                      onSubmitted: (_) => onSend(),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.emoji_emotions_outlined,
                        size: 18, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: hasText ? onSend : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hasText ? AppColors.primary : AppColors.divider,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentSheet extends StatelessWidget {
  const _AttachmentSheet();

  @override
  Widget build(BuildContext context) {
    final items = [
      _AttachmentItem(icon: Icons.camera_alt, label: 'Camera', color: AppColors.info),
      _AttachmentItem(icon: Icons.image, label: 'Gallery', color: AppColors.success),
      _AttachmentItem(icon: Icons.location_on, label: 'Location', color: AppColors.warning),
      _AttachmentItem(emoji: '🩸', label: 'Certificate', color: AppColors.primary),
    ];
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context
                .read<ChatBloc>()
                .add(const ChatEvent.attachmentClosed()),
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.9,
                    children: items
                        .map(
                          (it) => InkWell(
                            onTap: () => context
                                .read<ChatBloc>()
                                .add(const ChatEvent.attachmentClosed()),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: it.color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: it.emoji != null
                                      ? Text(
                                          it.emoji!,
                                          style: const TextStyle(fontSize: 22),
                                        )
                                      : Icon(it.icon, size: 22, color: it.color),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  it.label,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentItem {
  _AttachmentItem({
    this.icon,
    this.emoji,
    required this.label,
    required this.color,
  });

  final IconData? icon;
  final String? emoji;
  final String label;
  final Color color;
}
