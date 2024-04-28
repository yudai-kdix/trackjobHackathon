import 'dart:async';
import 'dart:math' as math;

import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/services/database_helper.dart';
import 'package:trackjob2024/services/notification_service.dart';

class NotificationWord {
  static late Future<List<Word>> wordList;
  static final noti = notification_service();
  static late Timer timer;
  static int startTime = 7; // 8時から
  static int endTime = 20; // 20時まで
  static int notificationInterval = 1; // 一時間毎
  // static bool flag = false;
  static bool flag = true;
  // TODO 初期をtrueにしているが、本来はfalseにしておく

  NotificationWord() {
    print("通知の初期設定を行います");
    wordList =
        DatabaseHelper().queryAllData('word').then((list) => list.cast<Word>());
    // 10秒待機
    Future.delayed(Duration(seconds: 10), () {});
    setNotification();
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
    print("通知実行");
    final words = await DatabaseHelper()
        .queryAllData('word')
        .then((list) => list.cast<Word>());
    ;
    // wordsの中からランダムに一つ選ぶ
    // nextIntは0がだめなのでいじる
    if (words.isEmpty) {
      // 単語が登録されていない場合は通知しない
      print("単語が登録されていません");
    } else {
      int index = math.Random().nextInt(words.length);
      noti.setNotification(words[index].term, index.toString());
    }
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
