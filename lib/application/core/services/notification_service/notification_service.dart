import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import 'package:blood_setu/application/core/services/routing/app_router.dart';
import 'package:blood_setu/application/core/services/routing/routing_utils.dart';
import 'package:blood_setu/domain/models/chat_contact.dart';
import 'package:blood_setu/domain/models/chat_screen_args.dart';

@lazySingleton
class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  String? _activeConversationId;
  int _notifId = 0;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
    const channel = AndroidNotificationChannel(
      'chat_messages',
      'Chat Messages',
      importance: Importance.high,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Android 13+ requires a runtime permission grant — show the system dialog.
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void setActiveConversation(String? id) => _activeConversationId = id;

  Future<void> showChatNotification({
    required String conversationId,
    required String senderName,
    required String messageText,
    required String currentUid,
    required String otherUid,
    required DateTime messageTime,
    required String bloodGroup,
    required String initials,
    required String avatarColor,
  }) async {
    if (conversationId == _activeConversationId) return;
    const maxLen = 60;
    final body = messageText.length > maxLen
        ? '${messageText.substring(0, maxLen)}…'
        : messageText;
    await _plugin.show(
      _notifId++,
      senderName,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'chat_messages',
          'Chat Messages',
          importance: Importance.high,
          priority: Priority.high,
          when: messageTime.millisecondsSinceEpoch,
          showWhen: true,
        ),
      ),
      payload: jsonEncode({
        'conversationId': conversationId,
        'currentUid': currentUid,
        'otherUid': otherUid,
        'senderName': senderName,
        'bloodGroup': bloodGroup,
        'initials': initials,
        'avatarColor': avatarColor,
      }),
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    final data = jsonDecode(response.payload ?? '{}') as Map<String, dynamic>;
    final conversationId = data['conversationId'] as String?;
    final currentUid = data['currentUid'] as String?;
    final otherUid = data['otherUid'] as String?;
    if (conversationId == null) return;
    AppRouter.router.push(
      PAGES.chat.screenPath,
      extra: ChatScreenArgs(
        conversationId: conversationId,
        currentUid: currentUid ?? '',
        otherUid: otherUid ?? '',
        contact: ChatContact(
          id: otherUid ?? '',
          name: data['senderName'] as String? ?? '',
          bloodGroup: data['bloodGroup'] as String? ?? '',
          initials: data['initials'] as String? ?? '',
          avatarColor: data['avatarColor'] as String? ?? '',
          online: false,
        ),
      ),
    );
  }
}
