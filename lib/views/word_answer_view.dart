import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/models/word.dart';

class WordAnswerView extends StatefulWidget {
  final int checkList;
  //final bool flag1;
  //final bool flag2;
  const WordAnswerView({Key? key, required this.checkList}) : super(key: key);

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

  late int id;
  bool ansORques = true;

  @override
  void initState() {
    super.initState();
    id = widget.checkList;
    //f1 = widget.flag1;
    //f2 = widget.flag2;
  }
  Widget build(BuildContext context) {
    String Term = words[id].term;
    String Difinition = words[id].definition;
    List <String>Tags = words[id].tags;
    int nex_id = id + 1;
    int pre_id = id - 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pushNamed(context, '/word_list'),
        ),
        title: const Text('質問と答え'),
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
      body: ListView(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  (id > 0) ? Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: pre_id))):null;
                },
              ),
              SizedBox(width: 200),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () =>
                  (id < words.length - 1) ? Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: nex_id))):null,
              ),
            ],
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
