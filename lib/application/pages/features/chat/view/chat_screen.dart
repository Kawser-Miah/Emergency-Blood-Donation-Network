import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../domain/models/chat_contact.dart';
import '../../../../../domain/models/chat_screen_args.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_attachment_sheet.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_date_separator.dart';
import '../widgets/chat_helpers.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_quick_replies.dart';
import '../widgets/chat_typing_row.dart';

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

class _ChatViewState extends State<_ChatView> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();
  double _prevBottomInset = 0;
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _inputFocusNode.addListener(() {
      if (_inputFocusNode.hasFocus && _showEmojiPicker) {
        setState(() => _showEmojiPicker = false);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inputFocusNode.dispose();
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      if (bottomInset > _prevBottomInset) {
        if (_showEmojiPicker) setState(() => _showEmojiPicker = false);
        _scrollToEnd();
      }
      _prevBottomInset = bottomInset;
    });
  }

  void _toggleEmojiPicker() {
    if (_showEmojiPicker) {
      setState(() => _showEmojiPicker = false);
    } else {
      FocusScope.of(context).unfocus();
      setState(() => _showEmojiPicker = true);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
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
        final typingStarted =
            !prev.maybeMap(ready: (s) => s.showTyping, orElse: () => false) &&
            next.maybeMap(ready: (s) => s.showTyping, orElse: () => false);
        return nextLen > prevLen || typingStarted;
      },
      listener: (context, _) => _scrollToEnd(),
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
                    ChatAppBar(
                      contact: widget.contact,
                      online: otherOnline,
                      lastSeen: otherLastSeen,
                    ),
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        reverse: true,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        children: _buildMessageList(
                          messages: messages,
                          showTyping: showTyping,
                        ),
                      ),
                    ),
                    ChatQuickReplies(
                      onTap: (text) => context
                          .read<ChatBloc>()
                          .add(ChatEvent.messageSent(text)),
                    ),
                    ChatInputBar(
                      controller: _inputController,
                      focusNode: _inputFocusNode,
                      input: input,
                      showEmojiPicker: _showEmojiPicker,
                      onChanged: (v) => context
                          .read<ChatBloc>()
                          .add(ChatEvent.inputChanged(v)),
                      onSend: () => context
                          .read<ChatBloc>()
                          .add(ChatEvent.messageSent(input)),
                      onAttach: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text('Coming soon'),
                        duration: Duration(seconds: 2),
                      )),
                      onEmoji: _toggleEmojiPicker,
                    ),
                    if (_showEmojiPicker)
                      SizedBox(
                        height: 280,
                        child: EmojiPicker(
                          textEditingController: _inputController,
                          onEmojiSelected: (_, _) {
                            context.read<ChatBloc>().add(
                              ChatEvent.inputChanged(_inputController.text),
                            );
                          },
                          config: const Config(),
                        ),
                      ),
                  ],
                ),
                if (showAttachment) const ChatAttachmentSheet(),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildMessageList({
    required List messages,
    required bool showTyping,
  }) {
    final items = <Widget>[];

    if (showTyping) {
      items.add(ChatTypingRow(contact: widget.contact));
      items.add(const SizedBox(height: 8));
    }

    String? currentLabel;
    for (int i = messages.length - 1; i >= 0; i--) {
      final msg = messages[i];
      final label = formatDateLabel(msg.timestamp);

      if (label != currentLabel) {
        if (currentLabel != null) {
          items.add(const SizedBox(height: 16));
          items.add(ChatDateSeparator(label: currentLabel));
          items.add(const SizedBox(height: 8));
        }
        currentLabel = label;
      }

      items.add(const SizedBox(height: 8));
      items.add(ChatBubble(
        message: msg,
        contact: widget.contact,
        currentUid: widget.currentUid,
      ));
    }

    if (currentLabel != null) {
      items.add(const SizedBox(height: 16));
      items.add(ChatDateSeparator(label: currentLabel));
      items.add(const SizedBox(height: 8));
    }

    return items;
  }

  Widget _loadingScaffold() => Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            ChatAppBar(contact: widget.contact),
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
            ChatAppBar(contact: widget.contact),
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
