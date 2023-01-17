import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class MyNotificationService {
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
    String? token = await FirebaseMessaging.instance.getToken().then((value) {
      print('token: $value');
      // return value;
    });
  }

  void saveToken() {}
  // late Notificator notification;

  // int transferNotifId = 1;

  // transferNotif(String title, String body) {
  //   String notificationKey = 'key';
  //   String _bodyText = 'notification test';
  //   notification.show(
  //     transferNotifId,
  //     title,
  //     body,
  //     data: {notificationKey: '[notification data]'},
  //     notificationSpecifics: NotificationSpecifics(AndroidNotificationSpecifics(
  //       autoCancelable: true,
  //     )),
  //   );
  // }

  // notification.show(1, "tes notif", 'ini adalah notif tes',
  //           imageUrl:
  //               "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
  //           data: {notificationKey: '[notification data]'},
  //           notificationSpecifics: NotificationSpecifics(
  //             AndroidNotificationSpecifics(
  //               autoCancelable: true,
  //             ),
  //           ))
  //       : print("notif tidak muncul");
}
