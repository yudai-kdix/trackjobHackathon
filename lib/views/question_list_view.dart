import 'package:flutter/material.dart';
import 'package:trackjob2024/components/hamburger_menu.dart';
import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/services/database_helper.dart';
import 'package:trackjob2024/views/word_answer_view.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({Key? key}) : super(key: key);

  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  // final List<Word> words = [
  //   Word(term: 'Example1', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
  //   Word(term: 'Example2', definition: 'これは例です', tags: ['Tag3', 'Tag2'], judge1: true, judge2: true),
  //   Word(term: 'Example3', definition: 'これは例です', tags: ['Tag1', 'Tag3'], judge1: true, judge2: true),
  //   Word(term: 'Example4', definition: 'これは例です', tags: ['Tag1', 'Tag4'], judge1: true, judge2: true),
  //   // 他の単語データ
  // ];
//  final List<Word> words = DatabaseHelper.instance.queryAllWords();
  // DatabaseHelper.instance.queryAllWords();
  // ほかクラスから保存されているデータ一覧を取得する処理を追加
  final Future<List<Word>> words =
      DatabaseHelper().queryAllData('word').then((list) => list.cast<Word>());

  var _city = '';
  bool flag1 = false;
  bool flag2 = false;
  String text = "";
  String search_tag = "";
  List<int> id_box = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.content_copy_rounded),
              ),
              TextSpan(text: '   '),
              TextSpan(
                text: '単語一覧',
                style: TextStyle(color: Colors.black, fontSize: 23),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const HamburgerMenu(),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity, //横幅いっぱいを意味する
            color: Color.fromARGB(255, 95, 160, 231), //広がっているか色をつけて確認
            child: ListTile(
              leading: Container(
                width: 250,
                height: 35,
                margin: const EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  onChanged: (value) {
                    text = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'tagを検索',
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          id_box = [];
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
                      flag1
                          ? Icons.check_box_rounded
                          : Icons.check_box_outlined,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      id_box = [];
                      setState(() {
                        id_box = [];
                        flag1 = !flag1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      flag2
                          ? Icons.bookmark_outlined
                          : Icons.bookmark_outline_outlined,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      id_box = [];
                      setState(() {
                        id_box = [];
                        flag2 = !flag2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Word>>(
                future: words,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        int id = snapshot.data![index].id!;
                        bool JUDGE = false;

                        //チェックアイコンがあるものは表示せず、タグアイコンのあるものは表示する
                        (flag1 && !snapshot.data![index].judge1) ||
                                (flag2 && snapshot.data![index].judge2)
                            ? JUDGE = false
                            : JUDGE = true;
                        ((search_tag == "") ||
                                    (snapshot.data![index].tags
                                        .contains(search_tag)) ||
                                    (snapshot.data![index].tags
                                        .contains(search_tag))) &&
                                JUDGE
                            ? id_box.add(id)
                            : id_box = id_box;
                        //タグ検索
                        return ((search_tag == "") ||
                                    (snapshot.data![index].tags
                                        .contains(search_tag))) &&
                                JUDGE
                            ? Card(
                                color: Color.fromARGB(255, 227, 239, 247),
                                child: ListTile(
                                  title: Text(snapshot.data![index].term),
                                  // subtitle:
                                  //     Text(snapshot.data![index].definition),
                                  trailing: Wrap(
                                    spacing: 8, // アイコンの間の幅を調整
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          snapshot.data![index].judge1
                                              ? Icons.check_box_outlined
                                              : Icons.check_box_rounded,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            id_box = [];
                                            snapshot.data![index].judge1 =
                                                !snapshot.data![index].judge1;
                                            DatabaseHelper().updateData(
                                                'word', snapshot.data![id]);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          snapshot.data![index].judge2
                                              ? Icons.bookmark_outline_outlined
                                              : Icons.bookmark_outlined,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            id_box = [];
                                            snapshot.data![index].judge2 =
                                                !snapshot.data![index].judge2;
                                            DatabaseHelper().updateData(
                                                'word', snapshot.data![id]);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.border_color_outlined),
                                        onPressed: () {
                                          setState(() {
                                            print(id);
                                            print(snapshot.data![index].id);
                                            DatabaseHelper()
                                                .deleteData('word', id);
                                            // DatabaseHelper().updateData('word',snapshot.data![id]);
                                          });
                                          //onpress action
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () =>
                                      //Navigator.pushNamed(context, '/detail', arguments: word),
                                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WordAnswerView(
                                              checkList: id_box,
                                              checkid: id,
                                            )),
                                  ),
                                ),
                              )
                            : SizedBox(height: 0);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
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
