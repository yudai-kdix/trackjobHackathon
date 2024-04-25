import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackjob2024/models/word.dart'; // 日付のフォーマットに使用


class WordDetailScreen extends StatelessWidget {
  final Word word;

  WordDetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('単語の詳細'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('単語: ${word.term}',
                style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 10),
            Text('定義: ${word.definition}',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            Text('タグ: ${word.tags.join(", ")}',
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 10),
            // Text('登録日: ${DateFormat('yyyy/MM/dd').format(word.registeredDate)}',
            //     style: Theme.of(context).textTheme.bodyText1),
            // SizedBox(height: 10),
            // Text('回答回数: ${word.answeredCount}',
            //     style: Theme.of(context).textTheme.bodyText1),
            // SizedBox(height: 10),
            // Text('正解回数: ${word.correctCount}',
            //     style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
