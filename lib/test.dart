import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifiTest {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // コンストラクタで通知の初期化を行う
  NotifiTest() {
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
  void setNotification(body) async {
    print('set');
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

  Future<void> scheduleNotification() async {
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

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '定期通知',
      'この通知は一定時間ごとに表示されます',
      RepeatInterval.everyMinute,
      generalNotificationDetails,
    );
  }

  // iOSで通知を受け取った時の処理
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // 受け取った通知のデータを処理する場所
  }

  // 通知を選択した時の処理
  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
}

class testView extends StatelessWidget{
  final NotifiTest notifiTest = NotifiTest();

  testView({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知テスト'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                notifiTest.setNotification('こんにちは');
              },
              child: const Text('通知を表示'),
            ),
            ElevatedButton(
              onPressed: () {
                notifiTest.scheduleNotification();
              },
              child: const Text('定期通知を表示'),
            ),
          ],
        ),
      ),
    );
  } 
}