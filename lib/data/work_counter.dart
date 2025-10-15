import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> workCounter = ValueNotifier<int>(0);

Future<void> loadCounter() async {
  final prefs = await SharedPreferences.getInstance();
  workCounter.value = prefs.getInt('work_counter') ?? 0;
}

Future<void> incrementCounter() async {
  workCounter.value++;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('work_counter', workCounter.value);
}
