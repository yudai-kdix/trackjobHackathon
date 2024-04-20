import 'package:flutter/material.dart';
import 'package:trackjob2024/models/word.dart';

class QuestionListView extends StatelessWidget {
  final List<Word> words = [
    Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2']),
    // 他の単語データ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語と質問の一覧'),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          Word word = words[index];
          return ListTile(
            title: Text(word.term),
            subtitle: Text(word.definition),
            onTap: () =>
                Navigator.pushNamed(context, '/detail', arguments: word),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addWord'),
      ),
    );
  }
}
