import 'package:flutter/material.dart';
import 'package:trackjob2024/models/tags.dart';
import 'package:trackjob2024/models/word.dart';
import 'package:trackjob2024/services/database_helper.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({Key? key}) : super(key: key);

  @override
  _AddWordScreenState createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _term = '';
  String _definition = '';
  String _tags = '';

  void _saveWord() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      DatabaseHelper().insertData(
          'word',
          Word(
              term: _term,
              definition: _definition,
              tags: [_tags],
              judge1: true,
              judge2: true,
              countTrue: 0,
              countFalse: 0));
      List<String> tag_list = _tags.split(',');
      int len = tag_list.length;
      for (int i = 0; i < len; i++) {
        DatabaseHelper().insertData(
            'tag', Tags(name: tag_list[i], countTrue: 0, countFalse: 0));
      }
      ;
      Navigator.pop(context); // 単語追加後は前の画面に戻る
    } else {
      // TODO エラーメッセージを表示
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.add_circle_outline),
              ),
              TextSpan(text: '   '),
              TextSpan(
                text: '単語の追加',
                style: TextStyle(color: Colors.black, fontSize: 23),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveWord,
          ),
        ],
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '単語'),
                onSaved: (value) => _term = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? '単語を入力してください'
                    : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '定義'),
                onSaved: (value) => _definition = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? '定義を入力してください' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'タグ (カンマ区切り)'),
                onSaved: (value) => _tags = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveWord,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text('保存'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                ),
                child: Text('キャンセル'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
