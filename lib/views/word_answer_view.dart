import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/models/word.dart';

class WordAnswerView extends StatefulWidget {
  const WordAnswerView({Key? key}) : super(key: key);

  @override
  _WordAnswerViewState createState() => _WordAnswerViewState();
}

class _WordAnswerViewState extends State<WordAnswerView> {
  Word word = Word(term: 'Example', definition: 'これは例です', tags: ['Tag1', 'Tag2'], judge1: true, judge2: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('質問と答え'),
      ),
      body: SizedBox(
        height: 500,
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
                child: Text(
                  style: TextStyle(fontSize: 50),
                  word.term,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addWord'),
      ),
    );
  }
}
