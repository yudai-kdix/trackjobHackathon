import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trackjob2024/test.dart';
import 'package:trackjob2024/views/add_word_view.dart';
import 'package:trackjob2024/views/question_list_view.dart';
import 'package:trackjob2024/views/word_detail_view.dart';
import 'package:trackjob2024/views/setting.dart';
import 'models/word.dart';

void main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '単語暗記アプリ',
      theme: ThemeData(
        // ここでテーマを設定
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        //ここで定義したものは他で Navigator.pushNamed(context, '/ルート名');で画面が遷移するはず
        '/': (context) => const MyHomePage(title: '単語暗記アプリ'),
        // TODO: クラスを設定したら外す。
        '/settings': (context) => SettingsView(), // 設定画面
        '/word_list': (context) => QuestionListView(), // 単語一覧画面
        '/word_add':(context) => const AddWordScreen(), // 単語追加画面
        // '/word_answer': (context) => WordAnswerView(), // 単語回答画面

        // 'word_detail': (context) => WordDetailView(), // 単語詳細画面
        '/test':(context) => testView()
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 1000,
            width: 1000,
            child: Card(
                child:Text(''),
            ),
          ),
          Positioned(
            top: 20,
            left: 1,
            width: 200.0,
            height: 200.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 1,
            width: 190.0,
            height: 200.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 1,
            right: 1,
            height: 200.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 1,
            width: 200.0,
            height: 200.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
          ),
          Positioned(
            top: 420,
            right: 1,
            width: 190.0,
            height: 100.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
          ),
          Positioned(
            top: 520,
            right: 1,
            width: 190.0,
            height: 100.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  //ansORques = !ansORques;
                });
              },
              child: Card(
                color: Colors.grey[200],
                child:Text('ha'),
              ),
            ),
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
