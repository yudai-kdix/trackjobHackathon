import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification_service {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late Timer timer;

  notification_service() {
    _initializeNotifications();
  }
  // 通知の初期設定
  void _initializeNotifications() async {
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
  // 引数で受け取ったbodyを通知する
  void setNotification(body) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
            // sound: 'example.mp3',
            presentAlert: true,
            presentBadge: true,
            presentSound: true);
    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    await Future.delayed(const Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.show(
        0, '単語暗記アプリ', body, platformChannelSpecifics);
  }
  // 1時間ごとに通知をスケジュールする
  // TODO 時間の制限を変数で管理
  void scheduleNotification() {
    timer = Timer.periodic(Duration(hours: 1), (Timer t) async {
      int hour = DateTime.now().hour;
      if (hour >= 8 && hour < 20) {
        // 8時から19時まで1時間ごとに通知
        await showHourlyNotification();
      }
    });
  }
  // 通知を表示する
  Future<void> showHourlyNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const iosDetails = DarwinNotificationDetails();
    const generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      '時間通知',
      '1時間ごとのリマインダー',
      generalNotificationDetails,
    );
  }
  // 通知をキャンセルする
  void cancelNotification() {
    timer.cancel();
  }
}
