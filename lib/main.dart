import 'package:flutter/material.dart';
import 'package:trackjob2024/services/notification_service.dart';
import 'package:trackjob2024/views/add_word_view.dart';
import 'package:trackjob2024/views/question_list_view.dart';
import 'package:trackjob2024/views/settings_view.dart';
import 'package:trackjob2024/views/word_detail_view.dart';
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
      body: Center(
        child: Column(
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('単語暗記アプリ')),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/word_list');
                },
                child: const Text('単語一覧')),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: const Text('設定画面')),
            ElevatedButton(
              child: Text("word list"),
              onPressed: () {
                Navigator.pushNamed(context, '/word_list');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/word_add'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
