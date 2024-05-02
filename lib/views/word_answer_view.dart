import 'package:flutter/material.dart';
import 'package:trackjob2024/components/hamburger_menu.dart';
import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/services/database_helper.dart';

class WordAnswerView extends StatefulWidget {
  final List<int> checkList;
  final int checkid;
  //final bool flag1;
  //final bool flag2;
  const WordAnswerView(
      {Key? key, required this.checkList, required this.checkid})
      : super(key: key);

  @override
  _WordAnswerViewState createState() => _WordAnswerViewState();
}

class _WordAnswerViewState extends State<WordAnswerView> {
  final Future<List<Word>> words =
      DatabaseHelper().queryAllData('word').then((list) => list.cast<Word>());
  late List<int> id_box;
  late int id;
  bool ansORques = true;
  bool correct_tag = true;
  bool irrcorrect_tag = true;

  @override
  void initState() {
    print('WordAnswerView');
    super.initState();
    id_box = widget.checkList;
    id = widget.checkid;
    //f1 = widget.flag1;
    //f2 = widget.flag2;
  }

  Widget build(BuildContext context) {
    //String Term = words[id].term;
    // String Difinition = words[id].definition;
    // List <String>Tags = words[id].tags;

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
    bool flag_make_sense = true;

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
      endDrawer: const HamburgerMenu(),
      body: Stack(
        children: [
          Flexible(
            child: FutureBuilder<List<Word>>(
              future: words,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Word word = snapshot.data![0];
                  for (int i = 0; i < snapshot.data!.length; i++) {
                    if (snapshot.data![i].id == id) {
                      id = i;
                      word = snapshot.data![i] ;
                    }
                  }
                  return ListView(
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
                            color: Color.fromARGB(255, 227, 239, 247),
                            child: Column(
                              children: [
                                Container(
                                  child: ListTile(
                                    trailing: Wrap(
                                      spacing: 8, // アイコンの間の幅を調整
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            word.judge1
                                                ? Icons.check_box_outlined
                                                : Icons.check_box_rounded,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              word.judge1 =
                                                  !word.judge1;

                                              DatabaseHelper().updateData(
                                                  'word', word);
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            word.judge2
                                                ? Icons
                                                    .bookmark_outline_outlined
                                                : Icons.bookmark_outlined,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              word.judge2 =
                                                  !word.judge2;
                                              DatabaseHelper().updateData(
                                                  'word', word);
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon:
                                              Icon(Icons.border_color_outlined),
                                          onPressed: () {
                                            //onpress action
                                            //onTap: () =>
                                            //Navigator.pushNamed(contextk, '/detail', arguments: word),
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
                                  child: ansORques
                                      ? Text(
                                          style: TextStyle(fontSize: 50),
                                          word.term)
                                      : Text(
                                          style: TextStyle(fontSize: 50),
                                          word.definition),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity, //横幅いっぱいを意味する
                        color:
                            Color.fromARGB(255, 95, 160, 231),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 700,
                                  width: double.infinity,
                                  child: Container(
                                    child: Text(''),
                                    color: Color.fromARGB(255, 95, 160, 231),
                                  ),
                                ),
                                Positioned(
                                  top: 1,
                                  right: 250,
                                  // width: 160.0,
                                  // height: 260.0,
                                  child: Text('わかる'),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 246,
                                  // width: 160.0,
                                  // height: 260.0,
                                  child: ((flag_make_sense == true) || correct_tag == false) ? IconButton(
                                    icon: Icon(
                                      correct_tag
                                          ? Icons.check_circle_outline
                                          : Icons.check_circle,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        correct_tag = !correct_tag;
                                        flag_make_sense = false;
                                        word.countTrue += 1;
                                        DatabaseHelper().updateData(
                                            'word', word);
                                      });
                                    },
                                  ):IconButton(
                                    icon: Icon(
                                      correct_tag
                                          ? Icons.check_circle_outline
                                          : Icons.check_circle,
                                    ),
                                    color: Color.fromARGB(255, 107, 171, 240),
                                    onPressed: () {
                                      setState(() {
                                        //correct_tag = !correct_tag;
                                      });
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 1,
                                  right: 90,
                                  // width: 160.0,
                                  // height: 260.0,
                                  child: Text('わからない'),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 100,
                                  // width: 160.0,
                                  // height: 260.0,
                                  child: ((flag_make_sense == true) || irrcorrect_tag == false) ? IconButton(
                                    icon: Icon(
                                      irrcorrect_tag
                                      ? Icons.announcement_outlined
                                      : Icons.announcement,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        irrcorrect_tag = !irrcorrect_tag;
                                        flag_make_sense = false;
                                        word.countFalse += 1;
                                        print(word.countFalse);
                                        DatabaseHelper()
                                              .updateData('word', word);
                                      });
                                    },
                                  ):IconButton(
                                    icon: Icon(
                                      irrcorrect_tag
                                      ? Icons.announcement_outlined
                                      : Icons.announcement,
                                    ),
                                    color: Color.fromARGB(255, 107, 171, 240),
                                    onPressed: () {
                                      setState(() {
                                        //irrcorrect_tag = !irrcorrect_tag;
                                      });
                                    },
                                  ),
                                ),
                              ], //広がっているか色をつけて確認
                        // child: ListTile(
                        //   trailing: Wrap(
                        //     spacing: 30, // アイコンの間の幅を調整
                        //     children: [
                        //       IconButton(
                        //         icon: Icon(
                        //           correct_tag
                        //               ? Icons.check_circle_outline
                        //               : Icons.check_circle,
                        //         ),
                        //         color: Colors.white,
                        //         onPressed: () {
                        //           setState(() {
                        //             correct_tag = !correct_tag;
                        //           });
                        //         },
                        //       ),
                        //       SizedBox(
                        //         height: 40,
                        //       child: RichText(
                        //         text: TextSpan(
                        //           children: [
                        //             TextSpan(
                        //               text: 'わかる',
                        //               style: TextStyle(color: Colors.black, fontSize: 20),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       ),
                        //       IconButton(
                        //         icon: Icon(
                        //           irrcorrect_tag
                        //               ? Icons.announcement_outlined
                        //               : Icons.announcement,
                        //         ),
                        //         color: Colors.white,
                        //         onPressed: () {
                        //           setState(() {
                        //             irrcorrect_tag = !irrcorrect_tag;
                        //           });
                        //         },
                        //       ),
                        //       Text('わからない'),
                        //       SizedBox(width: 80,),
                        //     ],
                        //   ),
                        // ),
                            ),
                      ),
                      SizedBox(
                        height: 120,
                        child: Card(
                          color: Color.fromARGB(255, 227, 239, 247),
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
                                  for (int i = 0;
                                      i < word.tags.length;
                                      i++) ...{
                                    Text('#'),
                                    Text(word.tags[i]),
                                    (i < word.tags.length - 1)
                                        ? Text(',')
                                        : Text(''),
                                    (i < word.tags.length - 1)
                                        ? Text('    ')
                                        : Text(''),
                                  },
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WordAnswerView(
                            checkList: id_box, checkid: pre_id)));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WordAnswerView(
                            checkList: id_box, checkid: nex_id)));
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
