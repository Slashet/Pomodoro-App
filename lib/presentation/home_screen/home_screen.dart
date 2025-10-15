import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// widget implementation
import 'package:pomodoro_app/presentation/home_screen/widgets/timer_widget.dart';
import 'package:pomodoro_app/presentation/home_screen/widgets/appbar_widget.dart';
import 'package:pomodoro_app/presentation/home_screen/widgets/navigation_bar.dart';
import 'package:pomodoro_app/presentation/home_screen/widgets/stats_widget.dart';
import 'package:pomodoro_app/presentation/home_screen/widgets/challange_widget.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyWidget();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.first,
        appBar: applicbar(context),
        body: IndexedStack(
          index: _index,
          children: [ChallangeWidget(), TimerWidget(), StatsWidget()],
        ),
        bottomNavigationBar: naviBar(
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
