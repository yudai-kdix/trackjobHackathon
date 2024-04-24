import 'package:flutter/material.dart';

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
      // ここで単語をデータベースに保存する処理を行う
      Navigator.pop(context); // 単語追加後は前の画面に戻る
    } else {
      // TODO エラーメッセージを表示
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('単語を追加'),
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
