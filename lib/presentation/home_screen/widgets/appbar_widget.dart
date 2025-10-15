import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

AppBar applicbar(BuildContext context) {
  return AppBar(
    title: Text(
      "PomodoRun",
      style: TextStyle(color: AppColors.fourth, fontWeight: FontWeight.bold),
    ),
    backgroundColor: AppColors.second,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        icon: const Icon(Icons.person_sharp, color: AppColors.fourth),
      ),
    ],
  );
}
