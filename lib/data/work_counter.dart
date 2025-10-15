import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> workCounter = ValueNotifier<int>(0);

Future<void> loadWorkCounter() async {
  final prefs = await SharedPreferences.getInstance();
  workCounter.value = prefs.getInt('work_counter') ?? 0;
}

Future<void> incrementWorkCounter() async {
  workCounter.value++;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('work_counter', workCounter.value);
}

Future<void> resetWorkCounter() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('work_counter', 0);
}
