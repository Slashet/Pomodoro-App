import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// screen implementation
import 'package:pomodoro_app/presentation/home_screen/home_screen.dart';
import 'package:pomodoro_app/presentation/profile_screen/profile_screen.dart';

void main() => runApp(PomodoroApp());

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro App',
      theme: ThemeData(primarySwatch: AppColors.appTheme),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _createRoute(HomeScreen(), settings);
          case '/profile':
            return _createRoute(prof(), settings);
          default:
            return null;
        }
      },
    );
  }

  PageRouteBuilder _createRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
        return FadeTransition(opacity: opacity, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
