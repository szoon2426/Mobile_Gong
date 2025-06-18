import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gong_gong_jae/pages/community.dart';
import 'package:gong_gong_jae/pages/contest.dart';
import 'package:gong_gong_jae/widgets/signup.dart';
import '../widgets/header_section.dart';
import '../widgets/timer_widget.dart';
import '../widgets/portfolio/study_calendar.dart';
import '../widgets/portfolio/pie_chart.dart';
import '../widgets/login.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  List<double> studyTimes = [];
  List<DateTime> dates = [];
  List<String> months = [];
  int selectedPeriod = 0;

  @override
  void initState() {
    super.initState();
    _generateCalendarData();
  }

  void _generateCalendarData() {
    final today = DateTime.now();
    final startDate = today.subtract(const Duration(days: 82));

    dates.clear();
    studyTimes.clear();
    months.clear();

    for (int i = 0; i < 83; i++) {
      final date = startDate.add(Duration(days: i));
      dates.add(date);
      studyTimes.add(Random().nextDouble() * 4);
    }

    final totalColumns = (dates.length / 7).ceil();
    for (int i = 0; i < totalColumns; i++) {
      final dateIndex = i * 7;
      months.add(dateIndex < dates.length ? "${dates[dateIndex].month}월" : "");
    }
  }

  void _onPeriodSelected(int index) {
    setState(() {
      selectedPeriod = index;
    });
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'portfolio',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 150,
                    child: IntrinsicHeight(
                      child: TimerWidget(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:20),
            _buildSectionTitle('공부 달력'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('현재 5일', style: TextStyle(fontSize: 16)),
            ),
            StudyCalendar(
              dates: dates,
              months: months,
              studyTimes: studyTimes,
            ),
            SizedBox(height: 20,),
            _buildSectionTitle('키워드별 그래프'),
            SizedBox(height: 10,),

            Expanded(
              child: PieChartWidget(studyTimes: studyTimes),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
