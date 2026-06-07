import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/chat_contact.dart';
import '../../../../../domain/models/chat_message.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/typing_dots.dart';
import '../../../../core/theme/colors.dart';
// import '../../../app/bloc/app_navigation_bloc.dart';
// import '../../../app/bloc/app_navigation_event.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

const List<String> _quickReplies = [
  "I'm coming",
  "Need 30 min",
  "Call me",
  "On the way 🚗",
];

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.contact});

  final ChatContact contact;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(),
      child: _ChatView(contact: contact),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.contact});

  final ChatContact contact;

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
      listenWhen: (prev, next) => prev.messages.length != next.messages.length,
      listener: (context, state) {
        _scrollToEnd();
      },
      builder: (context, state) {
        if (_inputController.text != state.input) {
          _inputController.value = TextEditingValue(
            text: state.input,
            selection:
                TextSelection.collapsed(offset: state.input.length),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  _AppBar(contact: widget.contact),
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                      children: [
                        _DateSeparator(),
                        const SizedBox(height: 16),
                        for (final msg in state.messages) ...[
                          _Bubble(message: msg, contact: widget.contact),
                          const SizedBox(height: 8),
                        ],
                        if (state.showTyping)
                          _TypingRow(contact: widget.contact),
                      ],
                    ),
                  ),
                  _QuickReplies(
                    onTap: (text) => context.read<ChatBloc>().add(
                          ChatEvent.sendRequested(text),
                        ),
                  ),
                  _InputBar(
                    controller: _inputController,
                    input: state.input,
                    onChanged: (v) => context
                        .read<ChatBloc>()
                        .add(ChatEvent.inputChanged(v)),
                    onSend: () => context
                        .read<ChatBloc>()
                        .add(ChatEvent.sendRequested(state.input)),
                    onAttach: () => context
                        .read<ChatBloc>()
                        .add(const ChatEvent.attachmentToggled()),
                  ),
                ],
              ),
              if (state.showAttachment) const _AttachmentSheet(),
            ],
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.contact});

  final ChatContact contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top + 4, 12, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
                // context.read<AppNavigationBloc>().add(
                //   const AppNavigationEvent.navigated(AppScreen.chats),
                // ),
            icon: const Icon(Icons.arrow_back, size: 22),
            color: AppColors.textSecondary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          Avatar(
            initials: contact.initials,
            colorHex: contact.avatarColor,
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
                    if (contact.online) ...[
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
                      const Text(
                        'Last seen 2 min ago',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textMuted),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone, size: 20),
            color: AppColors.textSecondary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
          borderRadius: BorderRadius.circular(99),
        ),
        child: const Text(
          'Today',
          style: TextStyle(fontSize: 10, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message, required this.contact});

  final ChatMessage message;
  final ChatContact contact;

  @override
  Widget build(BuildContext context) {
    final isSent = message.sent;
    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSent)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Avatar(
              initials: contact.initials,
              colorHex: contact.avatarColor,
              size: 28,
            ),
          ),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Column(
              crossAxisAlignment:
                  isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color:
                        isSent ? AppColors.primary : AppColors.dividerLight,
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
                      color: isSent ? Colors.white : AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted),
                    ),
                    if (isSent) ...[
                      const SizedBox(width: 4),
                      Text(
                        '✓✓',
                        style: TextStyle(
                          fontSize: 10,
                          color: message.read
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
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final r = _quickReplies[i];
          return GestureDetector(
            onTap: () => onTap(r),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              constraints: const BoxConstraints(minHeight: 44, maxHeight: 80),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            child: Container(color: Colors.black.withOpacity(0.3)),
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
                                    color: it.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: it.emoji != null
                                      ? Text(
                                          it.emoji!,
                                          style:
                                              const TextStyle(fontSize: 22),
                                        )
                                      : Icon(it.icon,
                                          size: 22, color: it.color),
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
