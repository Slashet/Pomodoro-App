import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

AppBar applicbar(BuildContext context) {
  return AppBar(
    leading: Image.asset("lib/assets/icon.png"),
    title: Text(
      "PomodoRun",
      style: TextStyle(color: AppColors.fourth, fontWeight: FontWeight.bold),
    ),
    backgroundColor: AppColors.second,
    actions: <Widget>[],
  );
}
