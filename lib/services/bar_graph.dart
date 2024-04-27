// import 'dart:math'; 
// import 'package:flutter/material.dart';
// import 'package:trackjob2024/models/tags.dart';

// const kColorPurple = Color.fromARGB(255, 85, 255, 66);
// const kColorPink = Color.fromARGB(255, 1, 97, 52);
// const kColorIndicatorBegin = kColorPink;
// const kColorIndicatorEnd = kColorPurple;
// const kColorTitle = Color(0xFF616161);
// const kColorText = Color(0xFF9E9E9E);
// const kElevation = 4.0;

// class _BarGraphPainter extends CustomPainter {
//   final double percentage; 
//   final double textCircleRadius;
//   final List<Tags> tags = [
//     Tags(name: 'abc', coutTrue: 3, coutFalse: 2, isMemorized: true),
//     Tags(name: 'abc', coutTrue: 5, coutFalse: 2, isMemorized: true),
//     Tags(name: 'abc', coutTrue: 2, coutFalse: 2, isMemorized: true),
//     Tags(name: 'abc', coutTrue: 6, coutFalse: 2, isMemorized: true),
//     Tags(name: 'abc', coutTrue: 3, coutFalse: 2, isMemorized: true),
//   ]; // 内側に表示される白丸の半径


//   _BarGraphPainter({
//     required this.percentage,
//     required this.textCircleRadius,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final int data_volume = tags.length;
//     for (int i = 1; i <= 300; i += 60) {
//       final per = i / 360.0;
//       // 割合（0~1.0）からグラデーション色に変換
//       final color = ColorTween(
//         begin: kColorIndicatorBegin,
//         end: kColorIndicatorEnd,
//       ).lerp(per)!;
//       final paint = Paint()
//         ..color = color
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 20;

//       //final spaceLen = 16; // 円とゲージ間の長さ
//       final lineLen = 100; // ゲージの長さ
//       //final angle = (2 * pi * per) - (pi / 2); // 0時方向から開始するため-90度ずらす
//       Rect r = Rect.fromLTRB(size.width * 0.2 + i - 5, size.height * 0.9 - lineLen, size.width * 0.2 + i, size.height * 0.9);
//       // 円の中心座標
//       // final offset0 = Offset(size.width * 0.2, size.height * 0.9);
//       // // 線の内側部分の座標
//       // final offset1 = offset0.translate(
//       //   size.width * 0.2 + i,
//       //   size.height * 0.9,
//       // );
//       // // 線の外側部分の座標
//       // final offset2 = offset1.translate(
//       //   size.width * 0.2 + i - 50,
//       //   size.height * 0.9 + lineLen + 50
//       // );
//       print(r.topLeft);
//       print(r.bottomLeft);
//       print(r.topLeft);

//       canvas.drawLine(r.topLeft, r.bottomLeft, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class BarGraph extends StatelessWidget {
//   final percentage = 0.7; //正解数÷総単語数
//   final size = 100.0;

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _BarGraphPainter(
//         percentage: percentage,
//         textCircleRadius: size * 0.5,
//       ),
//       // child: Container(
//       //   padding: const EdgeInsets.all(64),
//       //   child: Material(
//       //     color: Colors.white,
//       //     elevation: kElevation,
//       //     borderRadius: BorderRadius.circular(size * 0.5),
//       //     child: Container(
//       //       width: size,
//       //       height: size,
//       //       child: Center(
//       //         child: Text(
//       //           '${percentage * 100}%',
//       //           style: TextStyle(color: kColorPink, fontSize: 25),
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }