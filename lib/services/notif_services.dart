import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ibundiksha/services/secret.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:dio/dio.dart';

class MyNotificationService {
  SharedPrefs sharedPrefs = SharedPrefs();
  Dio dio = Dio();

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      print('token: $value');
      saveToken(value);
    });
  }

  void saveToken(String? token) {
    String? noRek = sharedPrefs.getString('nomorRekening');

    FirebaseFirestore.instance
        .collection('usersToken')
        .doc(noRek)
        .set({'token': token});
  }

  void sendPushNotification(
      {required String title,
      required String body,
      required String token}) async {
    try {
      await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': messaging_API
          },
        ),
        data: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'android_channel_id': 'dbbank'
            },
            'to': token,
          },
        ),
      );
    } on DioError catch (error, stacktrace) {
      if (kDebugMode) {
        print('Exception occured: $error stackTrace: $stacktrace');
        throw Exception(error.response);
      }
    }
  }
}
