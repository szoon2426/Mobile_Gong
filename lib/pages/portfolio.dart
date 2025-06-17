import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:math';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final Stopwatch _stopwatch = Stopwatch();
  late List<double> _studyTimes;
  Timer? _timer;
  int _selectedIndex = -1;
  bool _isTimerRunning = false;
  DateTime _currentDate = DateTime.now();
  List<DateTime> _dates = [];
  List<String> _months = [];
  int _selectedPeriod = 0; // 0: 전체, 1: 1개월 이내, 2: 3개월 이내

  @override
  void initState() {
    super.initState();
    _initializeCalendar();

    // 타이머 시작
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isTimerRunning && _selectedIndex != -1) {
        setState(() {
          _studyTimes[_selectedIndex] += 1 / 60.0;
        });
      }
    });
  }

  void _initializeCalendar() {
    _studyTimes = List.generate(83, (index) => Random().nextDouble() * 4.0);
    DateTime today = DateTime.now();
    DateTime startDate = today.subtract(Duration(days: today.weekday % 7));

    // 5주치 날짜 생성
    for (int i = 0; i < 83; i++) {
      DateTime date = startDate.add(Duration(days: i));
      _dates.add(date);
      if (i == 0 || date.day == 1) {
        _months.add("${date.month}월");
      } else {
        _months.add("");
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTimer() {
    setState(() {
      if (_isTimerRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _onPeriodSelected(int index) {
    setState(() {
      _selectedPeriod = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   children: [
            //     Icon(Icons.school, color: Colors.black),
            //     SizedBox(width: 8),
            //     Text(
            //       '공공재',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ],
            // ),
            Image.asset(
              'assets/images/gong_logo.png',
              width: 150,
              fit:BoxFit.cover
            ),
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 10),
                // Icon(Icons.login, color: Colors.black),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                  color:  Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
          ),
                SizedBox(width: 10),
                Icon(Icons.menu, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TimerWidget(_toggleTimer, _isTimerRunning),
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Padding(padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '공부달력',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),          
            )
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Padding(padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '현재 0일',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),          
            )
          ),
          SizedBox(height: 16,),
          StudyCalendar(_onDaySelected, _studyTimes, _dates, _months),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Padding(padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '키워드별 그래프',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),          
            )
          ),
          _buildPeriodSelector(),
          SizedBox(height: 8),
          _buildPieChart()
        ],
      ),
    );
  }

  /// 상단 기간 선택 버튼
  Widget _buildPeriodSelector() {
    final List<String> _periods = ["전체", "1개월이내", "3개월이내"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(_periods.length, (index) {
        return GestureDetector(
          onTap: () => _onPeriodSelected(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            // decoration: BoxDecoration(
            //   color: _selectedPeriod == index ? Colors.blue : Colors.grey[200],
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: Text(
              _periods[index],
              style: TextStyle(
                color: _selectedPeriod == index ? Colors.blue : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 원형 그래프
  Widget _buildPieChart() {
    return Expanded(
      child: Center(
        child: PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 50,
            sections:List.generate(_studyTimes.take(3).length, (index) {
            return PieChartSectionData(
              color: _getColor(index),
              value: _studyTimes[index],
              title: "${_studyTimes[index].toStringAsFixed(1)}%",
              radius: 60,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
          ),
        ),
      ),
    );
  }

  /// 색상 설정
  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blueAccent;
      case 1:
        return Colors.greenAccent;
      case 2:
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}
class TimerWidget extends StatelessWidget {
  final VoidCallback toggleTimer;
  final bool isRunning;

  TimerWidget(this.toggleTimer, this.isRunning);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
              onPressed: toggleTimer,
              iconSize: 32,
            ),
            Text(isRunning ? "타이머 실행 중" : "타이머 중지됨"),
          ],
        ),
      ),
    );
  }
}

// class StudyCalendar extends StatelessWidget {
//   final Function(int) onDaySelected;
//   final List<double> studyTimes;
//   final List<DateTime> dates;
//   final List<String> months;

//   StudyCalendar(this.onDaySelected, this.studyTimes, this.dates, this.months);

//   final List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

//   Color _getColor(double time) {
//     if (time < 1) {
//       return Colors.green[100]!;
//     } else if (time < 2) {
//       return Colors.green[300]!;
//     } else if (time < 3) {
//       return Colors.green[500]!;
//     } else {
//       return Colors.green[700]!;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> rows = [];

//     // 7줄 생성 (요일마다 세로로 정렬)
//     for (int weekday = 0; weekday < 7; weekday++) {
//       List<Widget> dayRow = [
//         Container(
//           width: 40,
//           child: Text(
//             weekdays[weekday],
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ];

//       for (int week = 0; week < 5; week++) {
//         int index = week * 7 + weekday;
//         dayRow.add(
//           GestureDetector(
//             onTap: () {
//               onDaySelected(index);
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               margin: EdgeInsets.symmetric(vertical: 2),
//               decoration: BoxDecoration(
//                 color: _getColor(studyTimes[index]),
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: Center(child: Text("${dates[index].day}")),
//             ),
//           ),
//         );
//       }

//       // 월 표시
//       if (months[weekday] != "") {
//         dayRow.add(Container(
//           width: 50,
//           child: Text(
//             months[weekday],
//             style: TextStyle(fontSize: 12, color: Colors.blue),
//           ),
//         ));
//       }

//       rows.add(Row(children: dayRow));
//     }

//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: rows,
//         ),
//       ),
//     );
//   }
// }

class StudyCalendar extends StatelessWidget {
  final Function(int) onDaySelected;
  final List<double> studyTimes;
  final List<DateTime> dates;
  final List<String> months;
  final double tileSize; // 네모칸의 크기를 조절할 수 있는 필드 추가

  StudyCalendar(this.onDaySelected, this.studyTimes, this.dates, this.months, {this.tileSize = 30.0});

  final List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  Color _getColor(double time) {
    if (time < 1) {
      return Colors.green[100]!;
    } else if (time < 2) {
      return Colors.green[300]!;
    } else if (time < 3) {
      return Colors.green[500]!;
    } else {
      return Colors.green[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: weekdays
                  .map((day) => Container(
                        height: tileSize,
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(day, style: TextStyle(fontSize: 12)),
                      ))
                  .toList(),
            ),
            SizedBox(width: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: tileSize,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1.0, // 정사각형으로 유지
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: tileSize,
                    height: tileSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                      color: _getColor(studyTimes[index]),
                    ),
                    child: Center(
                      child: Text(
                        "${dates[index].day}",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: months.where((element) => element.isNotEmpty).map((month) {
            return Text(
              month,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            );
          }).toList(),
        )
      ],
    );
  }
}