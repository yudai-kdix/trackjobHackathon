import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:trackjob2024/components/hamburger_menu.dart';
import 'package:trackjob2024/main.dart';

class SettingsView extends StatefulWidget {

  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String text = "";
  //String search_tag = "";
  int frequency = 60;
  int start_time = 8;
  int end_time = 20;
  bool Flag1 = false;
  bool Flag2 = false;
  bool notificationsEnabled = true;
  bool notificationsFavorite = true;
  bool notificationsStudied = true;


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
      endDrawer: const HamburgerMenu(),
      body: ListView(
        children: <Widget>[
          // Text('setting'),
          // Text('累計通知回数が多いものほど通知間隔をながくしたい'),
          // Text('単語ごとに出現確率を変化させることは可能か'),
          // Text('学習済みのものは通知しない、お気に入りは表示回数増やす、任意'),
          // Text('選択したタグのついているものの中から通知する'),
          // Text('登録日が一定以上前のものは学習済みでも通知する、出現確率をあげる'),
          // Text('画面に必要なものは、通知するもののタグ（無選択はすべて通知する）、通知頻度（単語各々ではなく通知そのものの頻度）、通知可能時間帯'),
          // SizedBox(height: 30,),
          Stack(
            children: [
              SizedBox(
                height: 700,
                width: 1000,
                child: Card(
                    child:Text(''),
                ),
              ),
              Positioned(
                top: 5,
                right: 10,
                left: 10,
                //width: 160.0,
                height: 245.0,
                child: Card(child: Text(''),color: Color.fromARGB(255, 227, 239, 247),)
              ),
              Positioned(
                top: 265,
                right: 10,
                left: 10,
                //width: 160.0,
                height: 280.0,
                child: Card(child: Text(''),color: Color.fromARGB(255, 227, 239, 247),)
              ),
              Positioned(
                top: 340,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.content_copy_rounded),
                      ),
                      TextSpan(text: '   '),
                      TextSpan(
                        text: '通知する単語のタグ',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 370,
                //right: 10,
                left: 60,
                //width: 160.0,
                //height: 260.0,
                child: Container(
                    width: 270,
                    height: 35,
                    //margin: const EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      onChanged: (value){
                        text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                        labelText: '通知する単語のカテゴリを入力',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     Icons.arrow_circle_right_outlined,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       search_tag = text;
                        //     });
                        //   },
                        // ),
                      ),
                      //onSaved: (value) => ,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Error'
                          : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
                    ),
                ),
              ),
              Positioned(
                top: 75,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.notifications_on_outlined),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '通知を受け取る',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 70,
                //right: 10,
                right: 30,
                //width: 160.0,
                //height: 260.0,
                child: CupertinoSwitch(
                  value: notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      notificationsEnabled = value;
                      print(value);
                      if (notificationsEnabled == false) {
                        notificationWord.stopTimer();
                      }else{
                        notificationWord.startTimer();
                      }
                    });
                  },
                ),
              ),
              Positioned(
                top: 130,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.assessment_outlined),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '通知頻度',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 125,
                //right: 10,
                right: 120,
                //width: 160.0,
                //height: 260.0,
                child: Container(
                  width: 60,
                  height: 35,
                  //margin: const EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      frequency = int.parse(value);
                      notificationWord.changeInterval(frequency);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), 
                      labelText: '1', //TODO ちょっとここあとで考える
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     Icons.arrow_circle_right_outlined,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       search_tag = text;
                      //     });
                      //   },
                      // ),
                    ),
                    //onSaved: (value) => ,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Error'
                        : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
                  ),
                ),
              ),
              Positioned(
                top: 130,
                //right: 10,
                right: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    // WidgetSpan(
                    //   child: Icon(Icons.assessment_outlined),
                    // ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '分に１回',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 20,
                //right: 10,
                left: 20,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    // WidgetSpan(
                    //   child: Icon(Icons.notifications_on_outlined),
                    // ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '通知設定',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              ),
              // Positioned(
              //   top: 100,
              //   //right: 10,
              //   left: 40,
              //   //width: 160.0,
              //   //height: 260.0,
              //   child: //Text('_______________________________________________'),
              const Divider(height: 225, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              const Divider(height: 335, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              const Divider(height: 450, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              const Divider(height: 825, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              const Divider(height: 935, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              const Divider(height: 1040, thickness: 1,indent: 40,endIndent: 40,color: Color.fromARGB(255, 14, 46, 97),),
              // ),
              Positioned(
                top: 285,
                //right: 10,
                left: 20,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    // WidgetSpan(
                    //   child: Icon(Icons.notifications_on_outlined),
                    // ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '通知する項目の設定',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 185,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.access_alarm),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '通知する時間帯',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 185,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: TextButton(
                    onPressed: () {
                      DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        showSecondsColumn: true,
                        onChanged: (date) {
                          print(date);
                        },
                        onConfirm: (date) {
                          print(date);
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.jp
                      );
                    },
                    child: const Text(
                      '時間を選択',
                      style: TextStyle(color: Colors.blue),
                    ),
                ),
                
              ),
              
              Positioned(
                top: 425,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check_box_outlined),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: '学習済みを通知する',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 420,
                //right: 10,
                right: 30,
                //width: 160.0,
                //height: 260.0,
                child: CupertinoSwitch(
                  value: notificationsStudied,
                  onChanged: (bool value) {
                    setState(() {
                      notificationsStudied = value;
                      if (notificationsStudied == true) {
                        //NotificationWord().startTimer();
                      } else {
                        //NotificationWord().stopTimer();
                      }
                    });
                  },
                ),
              ),
              Positioned(
                top: 480,
                //right: 10,
                left: 40,
                //width: 160.0,
                //height: 260.0,
                child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.bookmark_outline_outlined),
                    ),
                    TextSpan(text: '   '),
                    TextSpan(
                      text: 'お気に入りのみ通知する',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ),
              Positioned(
                top: 475,
                //right: 10,
                right: 30,
                //width: 160.0,
                //height: 260.0,
                child: CupertinoSwitch(
                  value: notificationsFavorite,
                  onChanged: (bool value) {
                    setState(() {
                      notificationsFavorite = value;
                      if (notificationsFavorite == true) {
                        //NotificationWord().startTimer();
                      } else {
                        //NotificationWord().stopTimer();
                      }
                    });
                  },
                ),
              ),
              // Positioned(
              //   top: 550,
              //   //right: 10,
              //   right: 130,
              //   width: 140.0,
              //   height: 70.0,
              //   child: InkWell(
              //     onTap: () {
              //       //保存
              //     },
              //     child: Card(
              //       child: Text(''),
              //       color: Colors.green,
              //     ),
              //   ),
              // ),
              // Positioned(
              //   top: 573,
              //   //right: 10,
              //   right: 143,
              //   //width: 160.0,
              //   //height: 260.0,
              //   child: RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: '設定を保存する',
              //         style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
              //       ),
              //     ],
              //   ),
              // ),
              // ),
              // Column(
              //   children: [
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //           WidgetSpan(
              //             child: IconButton(
              //               icon: Icon(
              //                 Flag1 ? Icons.check_box_rounded : Icons.check_box_outlined,
              //                 ),
              //               onPressed: () {
              //                 setState(() {
              //                   Flag1 = !Flag1;
              //                 });
              //               },
              //             ),
              //           ),
              //           TextSpan(text: '   '),
              //           TextSpan(
              //             text: '学習済み',
              //             style: TextStyle(color: Colors.black, fontSize: 20),
              //           ),
              //         ],
              //       ),
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //           WidgetSpan(
              //             child: IconButton(
              //               icon: Icon(
              //                 Flag2 ? Icons.bookmark_outline_outlined : Icons.bookmark_outlined,
              //                 ),
              //               onPressed: () {
              //                 setState(() {
              //                   Flag2 = !Flag2;
              //                 });
              //               },
              //             ),
              //           ),
              //           TextSpan(text: '   '),
              //           TextSpan(
              //             text: 'お気に入り',
              //             style: TextStyle(color: Colors.black, fontSize: 20),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
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
