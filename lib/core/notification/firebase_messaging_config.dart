import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../feature/home/data/local/notification_local_service.dart';
import '../../feature/home/data/model/notification_model.dart';

class FirebaseMessagingConfig {
  // Create an instance of FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  configNotification() async {
    // Request permission  for sending notifications
    final notificationSettings = await FirebaseMessaging.instance
        .requestPermission(provisional: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      log("User granted permission");

      // Initialize the FlutterLocalNotificationsPlugin andoid and iOS settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsDarwin =
          const DarwinInitializationSettings();
      // make them in one initialization settings
      final InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
          );
      // Initialize the FlutterLocalNotificationsPlugin with the settings
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
          final String? payload = notificationResponse.payload;
          if (notificationResponse.payload != null) {
            debugPrint('notification payload: $payload');
          }
          log("Notification clicked: ${notificationResponse.payload}");
        },
      );

      // Get the FCM token
      // This token is used to send messages to this device
      await FirebaseMessaging.instance.getToken().then((token) {
        if (token != null) {
          log("FCM Token: $token");
        } else {
          log("Failed to get FCM Token");
        }
      });

      // Handle the the payload
      FirebaseMessaging.instance.getInitialMessage().then((
        RemoteMessage? message,
      ) async {
        if (message != null) {
          final String title = message.notification?.title ?? '';
          final String body = message.notification?.body ?? '';
          final DateTime timestamp = DateTime.now();

          log("Initial message: $title - $body");

          // Save initial notification locally
          try {
            final notificationLocalService = NotificationLocalService();
            final localNotification = NotificationModel(
              title: title,
              body: body,
              timestamp: timestamp,
            );

            await notificationLocalService.addNotification(localNotification);
            log("Initial notification saved locally: $title");
          } catch (e) {
            log("Failed to save initial notification locally: $e");
          }

          // handleNotification(navigatorKey.currentContext!, message.data);
        }
      });
      // Listen for foreground messages that are received while the app is in the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final RemoteNotification notification = message.notification!;
        final String title = message.notification?.title ?? '';
        final String body = notification.body ?? '';
        final DateTime timestamp = DateTime.now();

        log("onMessage: $title - $body");

        // Save notification locally using the service
        await _saveNotificationLocal(title, body, timestamp);

        // Show the notification to user
        showNotification(title: title, desc: body);
      });
      // Listen for messages that are received when the app is in the background
      FirebaseMessaging.onMessageOpenedApp.listen((
        RemoteMessage message,
      ) async {
        final String title = message.notification?.title ?? '';
        final String body = message.notification?.body ?? '';
        final DateTime timestamp = DateTime.now();

        log("onMessageOpenedApp: $title - $body");

        // Save notification locally if not already saved
        try {
          final notificationLocalService = NotificationLocalService();
          final localNotification = NotificationModel(
            title: title,
            body: body,
            timestamp: timestamp,
          );

          await notificationLocalService.addNotification(localNotification);
          log("Background notification saved locally: $title");
        } catch (e) {
          log("Failed to save background notification locally: $e");
        }
      });
    }
  }

  Future<void> _saveNotificationLocal(
    String title,
    String body,
    DateTime timestamp,
  ) async {
    // Save notification locally using the service
    try {
      final notificationLocalService = NotificationLocalService();
      final localNotification = NotificationModel(
        title: title,
        body: body,
        timestamp: timestamp,
      );

      await notificationLocalService.addNotification(localNotification);
      log("Notification saved locally: $title");
    } catch (e) {
      log("Failed to save notification locally: $e");
    }
  }

  // Show a notification using FlutterLocalNotificationsPlugin for android
  showNotification({required String title, required String desc}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      notificationDetails,
      payload: 'item x',
    );
  }
}
