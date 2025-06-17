import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/popular_slider.dart';
import '../widgets/tabbed_contests.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            HeaderSection(), // ✅ 항상 고정
            /// ✅ contest + 타이머 Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "contest",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Text(
                        "00:00:00",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.timer, size: 18),
                    ],
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
