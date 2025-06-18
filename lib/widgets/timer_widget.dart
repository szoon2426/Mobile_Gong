import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷
import '../storage_helper.dart';    // 파일 저장 로직


enum TimerStatus { initial, readyToStart, running, paused }

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final Stopwatch _stopwatch = Stopwatch();
  final TextEditingController _controller = TextEditingController();

  TimerStatus _status = TimerStatus.initial;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  String _keyword = '';

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_keyword.trim().isEmpty) return;
    _stopwatch.start();
    _startTick();
    setState(() => _status = TimerStatus.running);
  }

  void _pause() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() => _status = TimerStatus.paused);
  }

  void _resume() {
    _stopwatch.start();
    _startTick();
    setState(() => _status = TimerStatus.running);
  }

  void _reset() async {
    _stopwatch.stop();
    _timer?.cancel();

    final minutes = _elapsed.inMinutes;
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (minutes > 0) {
      print("[📅 날짜별 저장] $today: $minutes분");
      await StorageHelper.writeStudyData(today, minutes);

      if (_keyword.trim().isNotEmpty) {
        print("[🏷️ 키워드별 저장] $_keyword: $minutes분");
        await StorageHelper.writeKeywordData(_keyword.trim(), minutes);
      }
    }

    _controller.clear();
    setState(() {
      _status = TimerStatus.initial;
      _elapsed = Duration.zero;
      _keyword = '';
    });
  }



  void _startTick() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed = _stopwatch.elapsed);
    });
  }

  String _formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_status == TimerStatus.initial) {
          setState(() => _status = TimerStatus.readyToStart);
        } else if (_status == TimerStatus.running) {
          _pause();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _status == TimerStatus.paused
              ? Colors.black.withOpacity(0.08)
              : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, // 🔥 세로 방향 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,
  
          children: [
            /// 타이머 시간
            Text(
              _formatTime(_elapsed),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            /// 키워드 입력 + ▶️
            if (_status == TimerStatus.readyToStart)
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _controller,
                      onChanged: (val) => _keyword = val,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: '#키워드',
                        isDense: true,
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _start,
                    icon: const Icon(Icons.play_arrow),
                    tooltip: '타이머 시작',
                  ),
                ],
              ),

            /// 일시정지 상태 → 재생/종료 아이콘
            if (_status == TimerStatus.paused)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _resume,
                    icon: const Icon(Icons.play_arrow),
                    padding: EdgeInsets.zero, // 🔥 여백 제거
                    constraints: const BoxConstraints(),
                    tooltip: '계속하기',
                  ),
                  SizedBox(width: 8,),
                  IconButton(
                    onPressed: _reset,
                    icon: const Icon(Icons.stop),
                    tooltip: '종료',
                    padding: EdgeInsets.zero, // 🔥 여백 제거
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
