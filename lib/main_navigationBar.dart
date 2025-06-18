import 'package:flutter/material.dart';
import 'pages/portfolio.dart';
import 'pages/contest.dart';
import 'pages/community.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 1; // 가운데 Contest부터 시작
  final PageController _pageController = PageController(initialPage: 1);

  final List<Widget> _pages = const [
    PortfolioPage(),
    ContestPage(),
    CommunityPage(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '포트폴리오',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: '콘테스트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '커뮤니티',
          ),
        ],
      ),
    );
  }
}
