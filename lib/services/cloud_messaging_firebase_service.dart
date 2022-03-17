import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails? platformChannelSpecifics;

  void configure() async {
    print(await _fcm.getToken());
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'push_notification',
        'push_notification_name',
        'push_notification_description',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation:
            BigTextStyleInformation(message.notification?.body ?? ""),
      );

      var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );
      _processMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  void _processMessage(RemoteMessage message) {
    _flutterLocalNotificationShow(message);
  }

  void _flutterLocalNotificationShow(RemoteMessage message) async {
    String payload;
    if (Platform.isIOS) {
      payload = message.data['payload'] ?? "";
    } else {
      payload = message.data['payload'] ?? "";
    }
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future myBackgroundMessageHandler(
      Map<String, dynamic> message) async {}

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  Future onSelectNotification(String? payload) async {}
}
