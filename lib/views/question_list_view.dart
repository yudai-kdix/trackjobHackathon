import 'package:flutter/material.dart';
import 'package:trackjob2024/models/word.dart';

class QuestionListView extends StatelessWidget {
  final List<Word> words = [
    Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2']),
    Word(term: 'Example2', definition: 'これは例2です', tags: ['Tag3', 'Tag4']),
    Word(term: 'Example3', definition: 'これは例3です', tags: ['Tag5', 'Tag6']),
    // 他の単語データ
  ];
  // ほかクラスから保存されているデータ一覧を取得する処理を追加

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
        onPressed: () => Navigator.pushNamed(context, '/word_add'),
      ),
    );
  }
}
