import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';
import 'package:pomodoro_app/data/data_managment.dart';

// screen implementation
import 'package:pomodoro_app/presentation/timer_screen/timer_widget.dart';
import 'package:pomodoro_app/presentation/stat_screen/stat_screen.dart';
import 'package:pomodoro_app/presentation/game_screen/game_widget.dart';

import 'package:pomodoro_app/presentation/widget/navigation_bar.dart';
import 'package:pomodoro_app/presentation/widget/appbar_widget.dart';

void main() => runApp(PomodoroApp());

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro App',
      theme: ThemeData(primarySwatch: AppColors.appTheme),
      home: myApp(),
    );
  }
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  int _index = 1;

  @override
  void initState() {
    super.initState();

    loadExpCounter();
    loadLevelCounter();
    loadWorkCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: applicbar(context),
      bottomNavigationBar: naviBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: IndexedStack(
        index: _index,
        children: [ChallangeWidget(), TimerWidget(), StatsWidget()],
      ),
    );
  }
}
