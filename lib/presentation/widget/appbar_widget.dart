import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

AppBar applicbar(BuildContext context) {
  return AppBar(
    // Leading icon
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset("lib/assets/icon.png", width: 32, height: 32),
    ),

    // Title
    title: const Text(
      "PomodoRun",
      style: TextStyle(
        color: AppColors.fourth,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    // Background color
    backgroundColor: AppColors.second,

    // Actions
    actions: [
      IconButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(
              'Every 25 minutes works give you exp and every 2 exp gives you 1 attack power',
            ),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        icon: Icon(Icons.info_outline),
      ),
    ],

    // Elevation
    elevation: 4,
  );
}
