import 'package:flutter/material.dart';
import 'contest_card.dart';
import '../../model/contest_model.dart';
import '../../contest_storage_helper.dart';

class TabbedContests extends StatefulWidget {
  const TabbedContests({super.key});

  @override
  State<TabbedContests> createState() => _TabbedContestsState();
}

class _TabbedContestsState extends State<TabbedContests> {
  List<Contest> _contests = [];

  @override
  void initState() {
    super.initState();
    _loadContests();
  }

  Future<void> _loadContests() async {
    final contests = await ContestStorageHelper.loadContests();
    setState(() => _contests = contests);
  }

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
          SizedBox(
            height: 600,
            child: TabBarView(
              children: [
                _buildContestGrid(_contests),
                _buildContestGrid(_contests), // 정렬 방식은 따로 구현 가능
                _buildContestGrid(_contests),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContestGrid(List<Contest> contests) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: contests.length,
      itemBuilder: (context, index) {
        final contest = contests[index];
        return ContestCard(
          imagePath: contest.imagePath,
          title: contest.title,
          dDay: contest.dDay,
          imgHeight: 100,
        );
      },
    );
  }
}
