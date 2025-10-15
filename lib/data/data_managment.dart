import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> workCounter = ValueNotifier<int>(0); // work counter for stat
ValueNotifier<int> levelCounter = ValueNotifier<int>(0); // xp counter for game
ValueNotifier<int> expCounter = ValueNotifier<int>(0); // exp counter for game

// load work counter
Future<void> loadWorkCounter() async {
  final prefs = await SharedPreferences.getInstance();
  workCounter.value = prefs.getInt("work_counter") ?? 0;
}

// load exp counter
Future<void> loadExpCounter() async {
  final prefs = await SharedPreferences.getInstance();
  expCounter.value = prefs.getInt("exp_counter") ?? 0;
}

// load level counter
Future<void> loadLevelCounter() async {
  final prefs = await SharedPreferences.getInstance();
  levelCounter.value = prefs.getInt("level_counter") ?? 0;
}

// update
Future<void> updateCounter(String dataName, int dataValue) async {
  switch (dataName) {
    case "level_counter":
      levelCounter.value = dataValue;
      break;
    case "work_counter":
      workCounter.value = dataValue;
      break;
    case "exp_counter":
      expCounter.value = dataValue;
      break;
  }
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(dataName, dataValue);
}

// reset
Future<void> resetCounter(String dataName) async {
  updateCounter(dataName, 0);
}
