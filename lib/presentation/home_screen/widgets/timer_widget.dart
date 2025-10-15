import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// Data implementation
import 'package:pomodoro_app/data/work_counter.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TimerWidget> {
  Timer? _timer;

  final int _breakTime = 300;
  final int _workTime = 1500;
  int _seconds = 1500;

  bool _isBreak = false;
  bool _isRun = false;

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;

    _isRun = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds -= 198;
        });
      } else {
        if (!_isBreak) {
          incrementWorkCounter();
        }
        _isBreak = !_isBreak;
        setState(() {
          _seconds = _isBreak ? _breakTime : _workTime;
        });
      }
    });
  }

  void _stopTimer() {
    if (_timer == null || !_timer!.isActive) return;
    _timer?.cancel();
    setState(() {
      _seconds = _workTime;
      _isBreak = false;
      _isRun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            width: 500,
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(300, 300),
                  painter: _QuarterCirclePainter(
                    color: _isBreak ? AppColors.fourth : AppColors.third,
                    currentAngel: _seconds,
                    angel: _isBreak ? _breakTime : _workTime,
                  ),
                ),
                FilledButton(
                  onPressed: _isRun ? _stopTimer : _startTimer,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(100),
                  ),
                  child: Text(
                    _formatTime(_seconds),
                    style: TextStyle(
                      color: _isBreak ? AppColors.third : AppColors.fourth,
                      shadows: null,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuarterCirclePainter extends CustomPainter {
  final Color color;
  final int currentAngel;
  final int angel;

  _QuarterCirclePainter({
    required this.color,
    required this.currentAngel,
    required this.angel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(
      rect,
      -pi / 2,
      -(pi / angel) * currentAngel * 2,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
