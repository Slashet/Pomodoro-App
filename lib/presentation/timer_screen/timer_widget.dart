import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// Data implementation
import 'package:pomodoro_app/data/data_managment.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;

  static const int _breakTime = 300;
  static const int _workTime = 1500;

  final ValueNotifier<int> _seconds = ValueNotifier<int>(_workTime);
  bool _isBreak = false;
  bool _isRunning = false;
  int streak = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _seconds.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _startTimer() {
    if (_timer?.isActive ?? false) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds.value > 0) {
        _seconds.value -= 1;
      } else {
        _handleTimerEnd();
      }
    });
  }

  void _handleTimerEnd() {
    if (!_isBreak) {
      streak++;
      if (streak > streakCounter.value) {
        updateCounter("streak_counter", streak);
      }

      updateCounter(
        "work_counter",
        workCounter.value + 1,
      ).catchError((e) => debugPrint("update work_counter error: $e"));
      updateCounter(
        "exp_counter",
        expCounter.value + 3,
      ).catchError((e) => debugPrint("update exp_counter error: $e"));
    }

    setState(() {
      _isBreak = !_isBreak;
    });

    _seconds.value = _isBreak ? _breakTime : _workTime;
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isBreak = false;
      _isRunning = false;
      _seconds.value = _workTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _isBreak ? AppColors.fourth : AppColors.third;
    final textColor = _isBreak ? AppColors.third : AppColors.fourth;
    final totalTime = _isBreak ? _breakTime : _workTime;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isBreak ? "Break Time" : "Work Time",
            style: TextStyle(
              color: AppColors.fourth,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _seconds,
                  builder: (_, seconds, __) {
                    return CustomPaint(
                      size: const Size(300, 300),
                      painter: _CircleProgressPainter(
                        color: activeColor,
                        seconds: seconds,
                        totalSeconds: totalTime,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _seconds,
                  builder: (_, seconds, __) {
                    return FilledButton(
                      onPressed: _isRunning ? _stopTimer : _startTimer,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: const CircleBorder(),
                      ),
                      child: Text(
                        _formatTime(seconds),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final Color color;
  final int seconds;
  final int totalSeconds;

  _CircleProgressPainter({
    required this.color,
    required this.seconds,
    required this.totalSeconds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final sweepAngle = -2 * pi * (seconds / totalSeconds);

    canvas.drawArc(rect, -pi / 2, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) {
    return oldDelegate.seconds != seconds || oldDelegate.color != color;
  }
}
