import 'package:flutter/material.dart';
import 'package:gong_gong_jae/widgets/signup.dart';
import '../widgets/header_section.dart';
import '../widgets/contest/popular_slider.dart';
import '../widgets/contest/tabbed_contests.dart';
import 'community.dart';
import 'portfolio.dart';
import '../widgets/login.dart';
import '../widgets/timer_widget.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('메뉴', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('로그인'),
              onTap: () {
                Navigator.pop(context); // 닫기
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('회원가입'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            HeaderSection(), // ✅ 항상 고정
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'contest',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Expanded( // ✅ 이 아래만 스크롤 가능
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PopularSlider(),
                    SizedBox(height: 16),
                    TabbedContests(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
