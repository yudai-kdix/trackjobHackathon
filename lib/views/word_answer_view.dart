import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/models/word.dart';

class WordAnswerView extends StatefulWidget {
  final List<String> checkList;
  final bool flag1;
  final bool flag2;
  const WordAnswerView({Key? key, required this.checkList, required this.flag1, required this.flag2}) : super(key: key);

  @override
  _WordAnswerViewState createState() => _WordAnswerViewState();
}

class _WordAnswerViewState extends State<WordAnswerView> {
  late List<String> W;
  late bool f1;
  late bool f2;
  //Word word = Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true);
  bool ansORques = true;

  @override
  void initState() {
    super.initState();
    W = widget.checkList;
    f1 = widget.flag1;
    f2 = widget.flag2;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('質問と答え'),
      ),
      body: SizedBox(
        height: 500,
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
                            f1 ? Icons.check_box_outlined : Icons.check_box_rounded,
                            ),
                          onPressed: () {
                            setState(() {
                              f1 = !f1;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            f2 ? Icons.bookmark_outline_outlined : Icons.bookmark_outlined,
                            ),
                          onPressed: () {
                            setState(() {
                              f2 = !f2;
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
                  child: ansORques ? Text(style: TextStyle(fontSize: 50),W[0]) : Text(style: TextStyle(fontSize: 50),W[1]),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/word_add'),
      ),
    );
  }
}
