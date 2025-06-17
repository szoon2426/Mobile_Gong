import 'package:flutter/material.dart';
import 'pages/portfolio.dart'; // PortfolioPage를 가져옴
import 'pages/contest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContestPage(), // 시작화면을 PortfolioPage로
    );
  }
}
