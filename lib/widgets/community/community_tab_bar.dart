import 'package:flutter/material.dart';

class CommunityTabBar extends StatelessWidget {
  const CommunityTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.black,
      tabs: [
        Tab(text: '전체'),
        Tab(text: '팀원모집'),
      ],
    );
  }
}
