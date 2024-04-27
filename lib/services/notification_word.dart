import 'dart:async';
import 'dart:math' as math;

import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/services/database_helper.dart';
import 'package:trackjob2024/services/notification_service.dart';

class NotificationWord {
  static late Future<List<Word>> wordList;
  static final noti = notification_service();
  static late Timer timer;
  static int startTime = 8; // 8時から
  static int endTime = 20; // 20時まで
  static int notificationInterval = 60; // 一時間毎
  // static bool flag = false;
  static bool flag = true;
  // TODO 初期をtrueにしているが、本来はfalseにしておく
  
  NotificationWord() {
    wordList = DatabaseHelper().queryAllData('word') as Future<List<Word>>;
    timer = Timer.periodic(Duration(minutes: notificationInterval),
        (Timer t) async {
      int hour = DateTime.now().hour;
      if (hour >= startTime && hour < endTime && flag) {
        // 8時から19時まで1時間ごとに通知
        setNotification();
      }
    });
  }

  void updateWordList(newWordList) {
    wordList = newWordList;
  }

  void setNotification() async {
    final words = await wordList;
    // wordsの中からランダムに一つ選ぶ
    int index = math.Random().nextInt(words.length);
    noti.setNotification(words[index].term, index.toString());
  }

  // 通知をキャンセルする
  void cancelNotification() {
    timer.cancel();
  }

  void restartTimer() {
    timer = Timer.periodic(Duration(minutes: notificationInterval),
        (Timer t) async {
      int hour = DateTime.now().hour;
      if (hour >= startTime && hour < endTime && flag) {
        // 8時から19時まで1時間ごとに通知
        setNotification();
      }
    });
  }

  // 通知の時間を変更
  void changeTime(int start, int end) {
    startTime = start;
    endTime = end;
  }

  void changeInterval(int interval) {
    notificationInterval = interval;
  }

  void startTimer() {
    flag = true;
  }

  void stopTimer() {
    flag = false;
  }
}
