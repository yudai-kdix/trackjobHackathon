// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// void scheduleNotification() {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');
//   final InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   final details = NotificationDetails(
//       android: AndroidNotificationDetails(
//           'channel id', 'channel name', 'channel description'));

//   tz.initializeTimeZones();
//   tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));

//   for (int i = 1; i <= 144; i++) {
//     // 24時間は1440分なので、10分ごとに通知を送ると144回になります。
//     flutterLocalNotificationsPlugin.zonedSchedule(
//         i,
//         'scheduled title',
//         'scheduled body',
//         tz.TZDateTime.now(tz.local).add(Duration(minutes: 10 * i)),
//         details,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.minute);
//   }
// }
