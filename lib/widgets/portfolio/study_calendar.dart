import 'package:flutter/material.dart';

class StudyCalendar extends StatelessWidget {
  final List<DateTime> dates;
  final List<String> months;
  final List<double> studyTimes;

  const StudyCalendar({
    super.key,
    required this.dates,
    required this.months,
    required this.studyTimes,
  });

  static const List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  static const double tileSize = 24.0;

  Color _getColor(double time) {
    if (time < 1) return Colors.grey[300]!;
    if (time < 2) return Colors.teal[200]!;
    if (time < 3) return Colors.teal[400]!;
    return Colors.teal[700]!;
  }

  @override
  Widget build(BuildContext context) {
    int totalColumns = (dates.length / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 📌 요일 세로 열
              Column(
                children: weekdays
                    .map(
                      (day) => Container(
                        height: tileSize,
                        width: 32,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          day,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(width: 8),

              /// 📌 네모칸 캘린더
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(totalColumns, (colIndex) {
                      return Column(
                        children: List.generate(7, (rowIndex) {
                          int index = colIndex * 7 + rowIndex;
                          if (index >= dates.length) {
                            return SizedBox(height: tileSize, width: tileSize);
                          }
                          return GestureDetector(
                            child: Container(
                              width: tileSize,
                              height: tileSize,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: _getColor(studyTimes[index]),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),

          /// 📌 하단 월(month) 표시
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 40), // 요일열과 일치
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(totalColumns, (colIndex) {
                      int index = colIndex * 7;
                      String label = index < months.length ? months[index] : "";
                      return Container(
                        width: tileSize,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
