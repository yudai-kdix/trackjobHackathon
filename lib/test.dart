// import 'package:flutter/material.dart';
// import 'package:trackjob2024/models/word.dart';
// import 'package:trackjob2024/views/word_answer_view.dart';
// import 'package:trackjob2024/services/database_helper.dart';

// class TestView extends StatefulWidget {
//   const TestView({Key? key}) : super(key: key);

//   @override
//   _QuestionListViewState createState() => _QuestionListViewState();
// }

// class _QuestionListViewState extends State<TestView> {
//   final Future<List<Word>> words = DatabaseHelper().queryAllData('word').then((list) => list.cast<Word>());
// //  final List<Word> words =
//   // DatabaseHelper.instance.queryAllWords();
//   // ほかクラスから保存されているデータ一覧を取得する処理を追加

//   var _city = '';
//   bool flag1 = false;
//   bool flag2 = false;
//   String text = "";
//   String search_tag = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_outlined),
//           onPressed: () => Navigator.pushNamed(context, '/'),
//         ),
//         title: const Text('単語と質問の一覧'),
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             SizedBox(
//               height: 80,
//               child: DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                 ),
//                 child: Text(
//                   'メニュー',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('ホーム'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/');
//               },
//             ),
//             ListTile(
//               title: Text('単語一覧'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/word_list');
//               },
//             ),
//             ListTile(
//               title: Text('単語の追加'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/word_add');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 50,
//             width: double.infinity, //横幅いっぱいを意味する
//             color: Color.fromARGB(255, 221, 226, 233), //広がっているか色をつけて確認
//             child: ListTile(
//               leading: Container(
//                 width: 250,
//                 height: 35,
//                 margin: const EdgeInsets.only(bottom: 5),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     text = value;
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     labelText: 'tagを検索',
//                     fillColor: Color.fromARGB(255, 255, 255, 255),
//                     filled: true,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.arrow_circle_right_outlined,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           search_tag = text;
//                         });
//                       },
//                     ),
//                   ),
//                   //onSaved: (value) => ,
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Error'
//                       : null, //valueがnullまたは空（isEmptyがtrue）の場合には指定されたエラーメッセージを返し、それ以外の場合にはnullを返してバリデーションが成功したことを示す
//                 ),
//               ),
//               trailing: Wrap(
//                 spacing: 0, // アイコンの間の幅を調整
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       flag1
//                           ? Icons.check_box_rounded
//                           : Icons.check_box_outlined,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         flag1 = !flag1;
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       flag2
//                           ? Icons.bookmark_outlined
//                           : Icons.bookmark_outline_outlined,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         flag2 = !flag2;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Flexible(
//             child: FutureBuilder<List<Word>>(
//               future: words,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index].term),
//                         subtitle: Text(snapshot.data![index].definition),
//                         onTap: () =>
//                             //Navigator.pushNamed(context, '/detail', arguments: word),
//                             Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   WordAnswerView(
//                                     checkList: [],
//                                     checkid: index,
//                                   )),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => Navigator.pushNamed(context, '/word_add'),
//       ),
//     );
//   }
// }
