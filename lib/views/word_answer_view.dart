import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/models/word.dart';

class WordAnswerView extends StatefulWidget {
  final List<int> checkList;
  final int checkid;
  //final bool flag1;
  //final bool flag2;
  const WordAnswerView({Key? key, required this.checkList, required this.checkid}) : super(key: key);

  @override
  _WordAnswerViewState createState() => _WordAnswerViewState();
}

class _WordAnswerViewState extends State<WordAnswerView> {
  final List<Word> words = [
    Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example2', definition: 'これは例です', tags: ['Tag3', 'Tag2'], judge1: true, judge2: true),
    Word(term: 'Example3', definition: 'これは例です', tags: ['Tag1', 'Tag3'], judge1: true, judge2: true),
    Word(term: 'Example4', definition: 'これは例です', tags: ['Tag1', 'Tag4'], judge1: true, judge2: true),
    // 他の単語データ
  ];

  late List<int> id_box;
  late int id;
  bool ansORques = true;
  bool correct_tag = true;
  bool irrcorrect_tag = true;

  @override
  void initState() {
    super.initState();
    id_box = widget.checkList;
    id = widget.checkid;
    //f1 = widget.flag1;
    //f2 = widget.flag2;
  }
  Widget build(BuildContext context) {
    String Term = words[id].term;
    String Difinition = words[id].definition;
    List <String>Tags = words[id].tags;
    
    int index_num = id_box.indexOf(id);
    int nex_index_num = index_num + 1;
    int pre_index_num = index_num - 1;
    if (nex_index_num >= id_box.length) {
      nex_index_num = 0;
    }
    if (pre_index_num < 0) {
      pre_index_num = id_box.length - 1;
    }
    int nex_id = id_box[nex_index_num];
    int pre_id = id_box[pre_index_num];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pushNamed(context, '/word_list'),
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
              leading: Icon(Icons.home_outlined),
              title: Text('ホーム'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.content_copy_rounded),
              title: Text('単語一覧'),
              onTap: () {
                Navigator.pushNamed(context, '/word_list');
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('単語の追加'),
              onTap: () {
                Navigator.pushNamed(context, '/word_add');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('設定'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              SizedBox(
                height: 450,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      ansORques = !ansORques;
                    });
                  },
                  child: Card(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            trailing: Wrap(
                              spacing: 8, // アイコンの間の幅を調整
                              children: [
                              IconButton(
                                  icon: Icon(
                                    words[id].judge1 ? Icons.check_box_outlined : Icons.check_box_rounded,
                                    ),
                                  onPressed: () {
                                    setState(() {                   
                                      words[id].judge1 = !words[id].judge1;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    words[id].judge2 ? Icons.bookmark_outline_outlined : Icons.bookmark_outlined,
                                    ),
                                  onPressed: () {
                                    setState(() {
                                      words[id].judge2 = !words[id].judge2;
                                  });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.border_color_outlined),
                                  onPressed: () {
                                    //onpress action
                                //onTap: () =>
                                  //Navigator.pushNamed(context, '/detail', arguments: word),
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ansORques ? Text(style: TextStyle(fontSize: 50),Term) : Text(style: TextStyle(fontSize: 50),Difinition),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity, //横幅いっぱいを意味する
                color: Color.fromARGB(255, 221, 226, 233), //広がっているか色をつけて確認
                child: ListTile(
                  trailing: Wrap(
                    spacing: 0, // アイコンの間の幅を調整
                    children: [
                      
                      IconButton(
                        icon: Icon(
                          correct_tag ? Icons.check_box_rounded : Icons.check_box_outlined,
                          ),
                        onPressed: () {
                          setState(() {
                            correct_tag = !correct_tag;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          irrcorrect_tag ? Icons.bookmark_outlined : Icons.bookmark_outline_outlined,
                          ),
                        onPressed: () {
                          setState(() {
                            irrcorrect_tag = !irrcorrect_tag;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: Card(
                  color: Colors.grey[200],
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          trailing: Wrap(
                            spacing: 8, // アイコンの間の幅を調整
                            children: [
                              IconButton(
                                icon: Icon(Icons.border_color_outlined),
                                onPressed: () {
                                    //onpress action
                                //onTap: () =>
                                  //Navigator.pushNamed(context, '/detail', arguments: word),
                                  },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < Tags.length; i++) ... {
                            Text('#'),
                            Text(Tags[i]),
                            (i < Tags.length - 1) ? Text(','):Text(''),
                            (i < Tags.length - 1) ? Text('    '):Text(''),
                          },
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 60,
            left: 1.0,
            width: 60.0,
            height: 500.0,
            child: TextButton(
              child: Text(''),
              style: TextButton.styleFrom(
                //fixedSize: const Size(50,700),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: id_box, checkid: pre_id)));
              },
            ),
          ),
          Positioned(
            top: 60,
            right: 1.0,
            width: 60.0,
            height: 500.0,
            child: TextButton(
              child: Text(''),
              style: TextButton.styleFrom(
                //fixedSize: const Size(50,700),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: id_box, checkid: nex_id)));
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
