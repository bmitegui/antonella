import 'dart:convert';

import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/router/app_router.dart';
import 'package:antonella/core/services/key_value_storage_service_impl.dart';
import 'package:antonella/core/services/local_notifications_service.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  // Private constructor for singleton pattern
  FirebaseMessagingService._internal();

  // Singleton instance
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  // Factory constructor to provide singleton instance
  factory FirebaseMessagingService.instance() => _instance;

  // Reference to local notifications service for displaying notifications
  LocalNotificationsService? _localNotificationsService;

  //Flag to track initialization status
  bool _isFirebaseMessagingInitialized = false;

  /// Initialize Firebase Messaging and sets up all message listeners
  Future<void> init(
      {required LocalNotificationsService localNotificationsService}) async {
    if (_isFirebaseMessagingInitialized) {
      return;
    }

    // Init local notifications service
    _localNotificationsService = localNotificationsService;

    // Handle FCM token
    _handlePushNotificationsToken();

    // Request user permission for notifications
    _requestPermission();

    // Register handler for background messages (app terminated)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listen for messages when the app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // Listen for notification taps when the app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Check for initial message that opened the app from terminated state
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 5), () {
          _onMessageOpenedApp(initialMessage);
        });
      });
    }

    // Mark initialization as complete
    _isFirebaseMessagingInitialized = true;
  }

  /// Retrieves and manages the FCM token for push notifications
  Future<void> _handlePushNotificationsToken() async {
    // Get the FCM token for the device
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('Push notifications token: $token');
    await sl<KeyValueStorageServiceImpl>().setKeyValue('fcmToken', token!);

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      debugPrint('FCM token refreshed: $fcmToken');
      // Optionally send token to your server for targeting this device
    }).onError((error) {
      // Handle errors during token refresh
      debugPrint('Error refreshing FCM token: $error');
    });
  }

  /// Requests notification permission from the user
  Future<void> _requestPermission() async {
    // Request permission for alerts, badges, and sounds
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Log the user's permission decision
    debugPrint('User granted permission: ${result.authorizationStatus}');
  }

  /// Handles messages received while the app is in the foreground
  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.data.toString()}');
    final notificationData = message.notification;
    if (notificationData != null) {
      if (message.data['redirect_to'] == 'CHAT') {
        sl<MessagesBloc>().add(UpdateMessagesEvent(
            content: notificationData.body!,
            type: message.data['type'],
            userId: message.data['user_id'],
            messageId: message.data['message_id'],
            senderId: message.data['sender_id']));
      }
      // Display a local notification using the service
      _localNotificationsService?.showNotification(notificationData.title,
          notificationData.body, jsonEncode(message.data));
    }
  }

  /// Handles notification taps when app is opened from the background or terminated state
  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint(
        'Notification caused the app to open: ${message.data.toString()}');
    if (message.data['redirect_to'] == 'CHAT') {
      pagesScreenKey.currentState?.jumpToPage(3);
    }
  }
}

/// Background message handler (must be top-level function or static)
/// Handles messages when the app is fully terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message received: ${message.data.toString()}');
  if (message.data['redirect_to'] == 'CHAT') {
    pagesScreenKey.currentState?.jumpToPage(3);
  }
}
