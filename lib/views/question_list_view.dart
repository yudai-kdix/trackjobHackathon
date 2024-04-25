import 'package:flutter/material.dart';
import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/views/word_answer_view.dart';
import 'package:trackjob2024/services/database_helper.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({Key? key}) : super(key: key);

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  final List<Word> words = [
    Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example2', definition: 'これは例です', tags: ['Tag3', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example3', definition: 'これは例です', tags: ['Tag1', 'Tag3'], judge1: true, judge2: true),
    Word(term: 'Example4', definition: 'これは例です', tags: ['Tag1', 'Tag4'], judge1: true, judge2: true),
    // 他の単語データ
  ];
  // ほかクラスから保存されているデータ一覧を取得する処理を追加

  var _city = '';
  bool flag1 = false;
  bool flag2 = false;
  String text = "";
  String search_tag = "";

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
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity, //横幅いっぱいを意味する
            color: Color.fromARGB(255, 221, 226, 233), //広がっているか色をつけて確認
            child: ListTile(
              leading: Container(
                width: 250,
                height: 35,
                margin: const EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  onChanged: (value){
                    text = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                    labelText: 'tagを検索',
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          search_tag = text;
                        });
                      },
                    ),
                  ),
                  //onSaved: (value) => ,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Error'
                      : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
                ),
              ),
              trailing: Wrap(
                spacing: 0, // アイコンの間の幅を調整
                children: [
                  
                  IconButton(
                    icon: Icon(
                      flag1 ? Icons.check_box_rounded : Icons.check_box_outlined,
                      ),
                    onPressed: () {
                      setState(() {
                        flag1 = !flag1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      flag2 ? Icons.bookmark_outlined : Icons.bookmark_outline_outlined,
                      ),
                    onPressed: () {
                      setState(() {
                        flag2 = !flag2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: words.length,
              itemBuilder: (context, index) {
                Word word = words[index];
                int id = index;
                bool JUDGE = false;

                //チェックアイコンがあるものは表示せず、タグアイコンのあるものは表示する
                (flag1 && !word.judge1) || (flag2 && word.judge2) ? JUDGE = false:JUDGE = true;
                //タグ検索
                return ((search_tag == "") || (word.tags.contains(search_tag))) && JUDGE ? Card(
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
                ):SizedBox(height: 0);
              },
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/word_add'),
      ),
    );
  }
}
