import 'package:flutter/material.dart';
import 'package:gong_gong_jae/main_navigationBar.dart';
import 'pages/portfolio.dart'; // PortfolioPage를 가져옴
import 'pages/contest.dart';
import 'pages/community.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationPage()
      //home: PortfolioPage(),
      //home: CommunityPage(), // 시작화면을 PortfolioPage로
      //home: ContestPage(),
    );
  }
}
