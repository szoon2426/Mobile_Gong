import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/timer_widget.dart';
import '../widgets/portfolio/study_calendar.dart';
import '../widgets/portfolio/pie_chart.dart';

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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(),

            /// ✅ portfolio + TimerWidget (오버레이 방식)
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
            _buildSectionTitle('공부 달력'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('현재 0일', style: TextStyle(fontSize: 16)),
            ),
            StudyCalendar(
              dates: dates,
              months: months,
              studyTimes: studyTimes,
            ),

            _buildSectionTitle('키워드별 그래프'),
            _buildPeriodTabs(),
            const SizedBox(height: 12),

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

  Widget _buildPeriodTabs() {
    const periods = ["전체", "1개월이내", "3개월이내"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(periods.length, (index) {
        final isSelected = selectedPeriod == index;
        return GestureDetector(
          onTap: () => _onPeriodSelected(index),
          child: Text(
            periods[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              decoration: isSelected ? TextDecoration.underline : null,
            ),
          ),
        );
      }),
    );
  }
}
