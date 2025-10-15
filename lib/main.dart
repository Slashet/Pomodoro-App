import 'package:flutter/material.dart';

// Color implementation
import 'package:pomodoro_app/Theme/colors.dart';
import 'package:pomodoro_app/data/data_managment.dart';

// Screen implementation
import 'package:pomodoro_app/presentation/timer_screen/timer_widget.dart';
import 'package:pomodoro_app/presentation/stat_screen/stat_screen.dart';
import 'package:pomodoro_app/presentation/game_screen/game_widget.dart';
import 'package:pomodoro_app/presentation/widget/navigation_widget.dart';

import 'package:pomodoro_app/presentation/widget/appbar_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Statları yüklemeden uygulamayı başlatma
  await loadExpCounter();
  await loadLevelCounter();
  await loadWorkCounter();

  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro App',
      theme: ThemeData(primarySwatch: AppColors.appTheme, useMaterial3: true),
      home: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: applicbar(context),
      bottomNavigationBar: AppNavigation(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: IndexedStack(
        index: _index,
        children: const [ChallangeWidget(), TimerWidget(), StatsWidget()],
      ),
    );
  }
}
