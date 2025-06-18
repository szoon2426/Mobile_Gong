import 'package:flutter/material.dart';
import 'package:gong_gong_jae/widgets/signup.dart';
import '../widgets/header_section.dart';
import '../widgets/community/community_tab_bar.dart';
import '../widgets/community/community_post_list.dart';
import '../widgets/community/community_write_form.dart';
import 'contest.dart';
import 'portfolio.dart';
import '../widgets/login.dart';
import '../widgets/timer_widget.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              HeaderSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'community',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
              SizedBox(height: 8),
              CommunityTabBar(),
              Expanded(child: CommunityPostList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // 키보드에 밀리지 않도록
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => const Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: CommunityWriteForm(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
