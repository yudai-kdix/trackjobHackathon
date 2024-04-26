import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/models/word.dart';

class SettingsView extends StatefulWidget {

  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String text = "";
  String search_tag = "";
  bool Flag1 = false;
  bool Flag2 = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.settings_outlined),
              ),
              TextSpan(text: '   '),
              TextSpan(
                text: '設定',
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
      body: ListView(
        children: <Widget>[
          Text('setting'),
          Text('累計通知回数が多いものほど通知間隔をながくしたい'),
          Text('単語ごとに出現確率を変化させることは可能か'),
          Text('学習済みのものは通知しない、お気に入りは表示回数増やす、任意'),
          Text('選択したタグのついているものの中から通知する'),
          Text('登録日が一定以上前のものは学習済みでも通知する、出現確率をあげる'),
          Text('画面に必要なものは、通知するもののタグ（無選択はすべて通知する）、通知頻度（単語各々ではなく通知そのものの頻度）、通知可能時間帯'),
          SizedBox(height: 30,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.settings_outlined),
                ),
                TextSpan(text: '   '),
                TextSpan(
                  text: '通知する単語のタグ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 280,
              height: 35,
              margin: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                onChanged: (value){
                  text = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                  labelText: '通知する単語のカテゴリを入力',
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_circle_right_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        search_tag = text;
                      });
                    },
                  ),
                ),
                //onSaved: (value) => ,
                validator: (value) => value == null || value.isEmpty
                    ? 'Error'
                    : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
              ),
            ),
          ),
          SizedBox(height: 30,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.settings_outlined),
                ),
                TextSpan(text: '   '),
                TextSpan(
                  text: '通知頻度',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.settings_outlined),
                ),
                TextSpan(text: '   '),
                TextSpan(
                  text: '通知する時間帯',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.settings_outlined),
                ),
                TextSpan(text: '   '),
                TextSpan(
                  text: '学習済みは通知するか、お気に入りは特別扱いするか',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: IconButton(
                        icon: Icon(
                          Flag1 ? Icons.check_box_rounded : Icons.check_box_outlined,
                          ),
                        onPressed: () {
                          setState(() {
                            Flag1 = !Flag1;
                          });
                        },
                      ),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '学習済み',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: IconButton(
                        icon: Icon(
                          Flag2 ? Icons.bookmark_outline_outlined : Icons.bookmark_outlined,
                          ),
                        onPressed: () {
                          setState(() {
                            Flag2 = !Flag2;
                          });
                        },
                      ),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: 'お気に入り',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
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
