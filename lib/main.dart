import 'package:flutter/material.dart';
import 'package:trackjob2024/components/hamburger_menu.dart';
import 'package:trackjob2024/models/tags.dart';
import 'package:trackjob2024/services/circle_graph.dart';
import 'package:trackjob2024/services/database_helper.dart';
import 'package:trackjob2024/services/notification_word.dart';
import 'package:trackjob2024/views/add_word_view.dart';
import 'package:trackjob2024/views/question_list_view.dart';
import 'package:trackjob2024/views/setting.dart';
// import 'package:trackjob2024/views/settings_view.dart';
import 'package:trackjob2024/views/word_detail_view.dart';
import 'package:trackjob2024/views/word_answer_view.dart';
import 'models/word.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
NotificationWord notificationWord = NotificationWord();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: '単語暗記アプリ',
      theme: ThemeData(
        // ここでテーマを設定
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 88, 154, 225)),
      ),
      routes: {
        //ここで定義したものは他で Navigator.pushNamed(context, '/ルート名');で画面が遷移するはず
        '/': (context) => const MyHomePage(title: '単語暗記アプリ'),
        // TODO: クラスを設定したら外す。
        '/settings': (context) => SettingsView(),
        '/word_list': (context) => QuestionListView(), // 単語一覧画面
        '/word_add': (context) => const AddWordScreen(), // 単語追加画面
        // '/word_answer': (context) => WordAnswerView(), // 単語回答画面
        // '/test': (context) => const TestView(),
        // 'word_detail': (context) => WordDetailView(), // 単語詳細画面
      },
      onGenerateRoute: (settings) {
        // 設定に基づいてルートを動的に生成
        if (settings.name == '/wordDetail') {
          final word = settings.arguments as Word;
          return MaterialPageRoute(
            builder: (context) => WordDetailScreen(word: word),
          );
        }
        // 他の動的なルートも同様に設定可能
        return null; // 該当するルートがない場合はnullを返す
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<List<Word>> words =
      DatabaseHelper().queryAllData('word').then((list) => list.cast<Word>());
  // final Future<List<Tags>> tags =
  //     DatabaseHelper().queryAllData('tag').then((list) => list.cast<Tags>());

  @override
  Widget build(BuildContext context) {
    // int wordFalse =DatabaseHelper().getCountFalse('word');
    // int wordTrue =DatabaseHelper().getCountTrue('word');
    // print("不正回数"+ wordFalse.toString());

    // double answerRate;
    // if (wordFalse + wordTrue == 0) {
    //   answerRate = 0;
    // }else{
    //   answerRate = wordTrue / (wordFalse + wordTrue);
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      endDrawer: const HamburgerMenu(),
      body: ListView(
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 700,
                width: 1000,
                child: Card(
                  child: Text(''),
                ),
              ),
              // Positioned(
              //   top: 20,
              //   left: 1,
              //   width: 230.0,
              //   height: 240.0,
              //   child: InkWell(
              //     onTap: () {
              //       setState(() {
              //         //ansORques = !ansORques;
              //       });
              //     },
              //     child: Card(
              //       color: Colors.grey[200],
              //       child:Text(''),
              //     ),
              //   ),
              // ),
              Positioned(
                top: 30,
                right: 10,
                //left: 10,
                width: 160.0,
                height: 260.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      //ansORques = !ansORques;
                    });
                  },
                  child: const Card(
                    color: Color.fromARGB(255, 227, 239, 247),
                    child: Text(''),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 35,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: '   '),
                      TextSpan(
                        text: '学習到達度',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 71, 110),
                            fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 65,
                  right: 170,
                  //width: 200.0,
                  //height: 200.0,
                  child: FutureBuilder<double>(
                    future: DatabaseHelper().getAnsRate('word'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // データをロード中の場合の表示
                        return const Text('Loading...');
                      } else if (snapshot.hasError) {
                        // エラーが発生した場合の表示
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // データが正常にロードされた場合の表示
                        return CircleGraph(
                          double.parse(snapshot.data!.toStringAsFixed(2))
                          ,
                        );
                      }
                    },
                  )
                ),
              Positioned(
                top: 60,
                right: -42,
                width: 160.0,
                height: 260.0,
                child: FutureBuilder<int>(
                  future: DatabaseHelper().getCountTrue('word'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データをロード中の場合の表示
                      return const Text('Loading...');
                    } else if (snapshot.hasError) {
                      // エラーが発生した場合の表示
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // データが正常にロードされた場合の表示
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '正解数: ${snapshot.data}', // 非同期で取得した値を表示
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 60,
                right: -12,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.check_circle_outline),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: -42,
                width: 160.0,
                height: 260.0,
                child: FutureBuilder<int>(
                  future: DatabaseHelper().getCountFalse('word'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データをロード中の場合の表示
                      return const Text('Loading...');
                    } else if (snapshot.hasError) {
                      // エラーが発生した場合の表示
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // データが正常にロードされた場合の表示
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '不正解数: ${snapshot.data}', // 非同期で取得した値を表示
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 120,
                right: -12,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.announcement_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 180,
                right: -42,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan( 
                        text: '未回答： 0', //TODO ここなんとかする
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 180,
                right: -12,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.question_mark_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 240,
                right: -32,
                width: 160.0,
                height: 260.0,
                child: FutureBuilder<double>(
                  future: DatabaseHelper().getAnsRate('word'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データをロード中の場合の表示
                      return const Text('Loading...');
                    } else if (snapshot.hasError) {
                      // エラーが発生した場合の表示
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // データが正常にロードされた場合の表示
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '正解率: ${(snapshot.data!*100).floor()}', // 非同期で取得した値を表示
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 242,
                right: -100,
                width: 160.0,
                height: 260.0,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "%",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 310,
                left: 20,
                right: 20,
                height: 180.0,
                child: Card(
                  color: Color.fromARGB(255, 180, 216, 255),
                  child: Text(''),
                ),
              ),
              Positioned(
                top: 320,
                left: 35,
                // right: 1,
                //height: 200.0,
                child: LimitedBox(
                  maxWidth: 320,
                  maxHeight: 160,
                  child: FutureBuilder<List<Word>>(
                    future: words,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<int> id_box = [];
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          id_box.add(i);
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WordAnswerView(checkList: id_box, checkid: index,)));
                              },
                              child: Card(
                                child: SizedBox(
                                  width: 150,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        //Text('${snapshot.data![index].term}'),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text: '${snapshot.data![index].term}',
                                                style: TextStyle(color: Colors.black, fontSize: 22),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Text(
                                        //     '${snapshot.data![index].countTrue}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 530,
                right: 260,
                width: 90.0,
                height: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/word_list');
                    });
                  },
                  child: const Card(
                    color: Color.fromARGB(255, 124, 175, 237),
                    child: Icon(
                      Icons.content_copy_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 530,
                right: 40,
                width: 90.0,
                height: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/settings');
                    });
                  },
                  child: const Card(
                    color: Color.fromARGB(255, 152, 152, 152),
                    child: Icon(
                      Icons.settings_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 530,
                right: 150,
                width: 90.0,
                height: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/word_add');
                    });
                  },
                  child: const Card(
                    color: Color.fromARGB(255, 117, 214, 141),
                    child: Icon(Icons.add_circle_outline, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () => Navigator.pushNamed(context, '/word_add'),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.pushNamed(context, '/word_add'),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
