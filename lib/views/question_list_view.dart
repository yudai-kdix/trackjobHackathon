import 'package:flutter/material.dart';
import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/views/word_answer_view.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({Key? key}) : super(key: key);

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  final List<Word> words = [
    Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example2', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example3', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example4', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    // 他の単語データ
  ];

  var _city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        title: const Text('単語と質問の一覧'),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Text(
                  'メニュー',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('ホーム'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('単語一覧'),
              onTap: () {
                Navigator.pushNamed(context, '/word_list');
              },
            ),
            ListTile(
              title: Text('単語の追加'),
              onTap: () {
                Navigator.pushNamed(context, '/word_add');
              },
            ),
          ],
        ),
      ),
        
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          Word word = words[index];
          int id = index;
          return Card(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(word.term),
              subtitle: Text(word.definition),
              trailing: Wrap(
                spacing: 8, // アイコンの間の幅を調整
                children: [
                  IconButton(
                    icon: Icon(
                      word.judge1 ? Icons.check_box_outlined : Icons.check_box_rounded,
                      ),
                    onPressed: () {
                      setState(() {
                        word.judge1 = !word.judge1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      word.judge2 ? Icons.bookmark_outline_outlined : Icons.bookmark_outlined,
                      ),
                    onPressed: () {
                      setState(() {
                        word.judge2 = !word.judge2;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.border_color_outlined),
                    onPressed: () {
                      //onpress action
                    },
                  ),
                ],
              ),
              onTap: () =>
                //Navigator.pushNamed(context, '/detail', arguments: word),
                Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: id)),
              ),
            ),
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
