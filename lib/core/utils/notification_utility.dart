
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../navigation/navigation_manager.dart';

class NotificationUtility {
  String topPic = "your-topic";

  Future<void> subscribeToNewsTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic(topPic);
    print("✅ '$topPic' 토픽에 구독되었습니다.");
  }

  Future<void> unsubscribeFromNewsTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topPic);
    print("❌ '$topPic' 토픽에서 구독 해제되었습니다.");
  }

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title.
    description: 'This channel is used for alert notifications.', // description
    importance: Importance.high,
  );

  Future<void> initMessaging() async {

    subscribeToNewsTopic();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //iOS foreground 알림표시.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        if (message.data != null) {
          flutterLocalNotificationsPlugin.show(
              hashCode,
              message.notification!.title,
              message.notification!.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: DarwinNotificationDetails( // ← iOS용 설정
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                  sound: 'default',
                  subtitle: message.notification?.body ?? '',
                ),
              ));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp : $event");
      ScaffoldMessenger.of(NavigationManager.navigatorKey.currentContext!).showSnackBar( SnackBar(content: Text("onMessageOpenedApp --> ${event.toMap().toString()}")),);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        ScaffoldMessenger.of(NavigationManager.navigatorKey.currentContext!).showSnackBar( SnackBar(content: Text("getInitialMessage --> ${message.toMap().toString()}")),);
      }
    });

  }

}