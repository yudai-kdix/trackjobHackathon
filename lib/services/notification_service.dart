import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification_service {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late Timer timer;
  // 通知の時間設定
  int startTime = 8; // 8時から
  int endTime = 20; // 20時まで
  int notificationInterval = 1; // 一時間毎

  //  メモ 
  // 今通知を1時間毎に自動に実行するメソッドを書いたが、単語をランダムに送ることを考えると、別の場所で1時間毎に通知を呼び出すメソッドにしたほうがいいかも
  
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
  void scheduleNotification() {
    timer = Timer.periodic(Duration(hours: notificationInterval), (Timer t) async {
      int hour = DateTime.now().hour;
      if (hour >= startTime && hour < endTime) {
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

  // 通知の時間を変更
  void changeTime(int start, int end) {
    startTime = start;
    endTime = end;
  }

  void changeInterval(int interval) {
    notificationInterval = interval;
  }
}
