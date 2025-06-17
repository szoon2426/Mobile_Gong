import 'package:flutter/material.dart';
import 'contest_card.dart';

class TabbedContests extends StatelessWidget {
  const TabbedContests({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '공모전 모아보기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: '전체'),
              Tab(text: '인기순'),
              Tab(text: '마감일순'),
            ],
          ),

          /// ✅ 이 부분: TabBarView → SizedBox로 높이 주거나 shrinkWrap 되도록 변경
          SizedBox(
            height: 600, // 고정 높이 지정 (또는 MediaQuery.of(context).size.height * 0.7)
            child: TabBarView(
              children: [
                _buildContestGrid(),
                _buildContestGrid(),
                _buildContestGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContestGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // 스크롤은 SingleChildScrollView가 담당
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7, // 수정
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return const ContestCard(
          imagePath: 'assets/sample.png',
          title: '공모전이름',
          dDay: 'D-12',
        );
      },
    );
  }
}
