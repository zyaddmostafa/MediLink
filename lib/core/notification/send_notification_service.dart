import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:googleapis_auth/auth_io.dart' as auth;

import '../api_helpers/dio_factory.dart';

// Service to send notifications using Firebase Cloud Messaging like from device to device
class SendNotificationService {
  final Dio dio = DioFactory.getDio();
  Future<String> getAccessToken() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/notification/notificatontest-942e0-5fbebfbcd5ac.json',
      );

      final accountCredentials = auth.ServiceAccountCredentials.fromJson(
        jsonString,
      );

      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = await auth.clientViaServiceAccount(
        accountCredentials,
        scopes,
      );

      return client.credentials.accessToken.data;
    } catch (e) {
      print('Error loading service account file: $e');
      print(
        'Please add your Firebase service account JSON file to assets/notification/',
      );
      rethrow;
    }
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final String accessToken = await getAccessToken();
    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/notificatontest-942e0/messages:send';

    final response = await dio.post(
      fcmUrl,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: {
        'message': {
          'token': token,
          'notification': {'title': title, 'body': body},
          'data': data, // Add custom data here

          'android': {
            'notification': {
              "sound": "custom_sound",
              'click_action':
                  'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
              'channel_id': 'high_importance_channel',
            },
          },
          'apns': {
            'payload': {
              'aps': {"sound": "custom_sound.caf", 'content-available': 1},
            },
          },
        },
      },
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.data}');
    }
  }
}

handleNotification(BuildContext context, Map<String, dynamic> data) {
  String route = data['route'];
  String id = data['id'];

  if (route == '/product_details') {}
}
