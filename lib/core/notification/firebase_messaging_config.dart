import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      ) {
        if (message != null) {
          log(
            "Initial message: ${message.notification?.title} - ${message.notification?.body}",
          );
          // handleNotification(navigatorKey.currentContext!, message.data);
        }
      });
      // Listen for foreground messages that are received while the app is in the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final RemoteNotification notification = message.notification!;

        final body = notification.body;

        log(
          "onMessage: ${message.notification?.title} - ${message.notification?.body}",
        );
        showNotification(
          title: message.notification?.title ?? '',
          desc: body ?? '',
        );
        // handleNotification(navigatorKey.currentContext!, message.data);
      });
      // Listen for messages that are received when the app is in the background

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log(
          "onMessageOpenedApp: ${message.notification?.title} - ${message.notification?.body}",
        );
      });
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
