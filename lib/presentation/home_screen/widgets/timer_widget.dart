import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int breakTime = 300;
  int workTime = 1500;
  int _seconds = 1500;

  Timer? _timer;

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds -= 1;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(300, 300),
              painter: _QuarterCirclePainter(
                color: AppColors.second,
                currentAngel: _seconds,
                angel: workTime,
              ),
            ),
            FilledButton(
              onPressed: _startTimer,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: CircleBorder(),
                padding: EdgeInsets.all(100),
              ),
              child: Text(
                _formatTime(_seconds),
                style: const TextStyle(
                  shadows: null,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
