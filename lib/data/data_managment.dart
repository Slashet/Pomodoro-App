import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> workCounter = ValueNotifier<int>(0); // work counter for stat
ValueNotifier<int> levelCounter = ValueNotifier<int>(0); // xp counter for game
ValueNotifier<int> expCounter = ValueNotifier<int>(0); // exp counter for game
ValueNotifier<int> streakCounter = ValueNotifier<int>(
  0,
); // streak counter for game

// load work counter
Future<void> loadWorkCounter() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    workCounter.value = prefs.getInt("work_counter") ?? 0;
  } catch (e, stackTrace) {
    debugPrint(
      "data_managment.dart => loadWorkCounter => Error: $e\n$stackTrace",
    );
  }
}

// streak work counter
Future<void> loadStreakCounter() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    workCounter.value = prefs.getInt("streak_counter") ?? 0;
  } catch (e, stackTrace) {
    debugPrint(
      "data_managment.dart => loadStreakCounter => Error: $e\n$stackTrace",
    );
  }
}

// load exp counter
Future<void> loadExpCounter() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    workCounter.value = prefs.getInt("exp_counter") ?? 0;
  } catch (e, stackTrace) {
    debugPrint(
      "data_managment.dart => loadExpCounter => Error: $e\n$stackTrace",
    );
  }
}

// load level counter
Future<void> loadLevelCounter() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    workCounter.value = prefs.getInt("level_counter") ?? 0;
  } catch (e, stackTrace) {
    debugPrint(
      "data_managment.dart => loadLevelCounter => Error: $e\n$stackTrace",
    );
  }
}

// update
Future<void> updateCounter(String dataName, int dataValue) async {
  try {
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
      case "streak_counter":
        streakCounter.value = dataValue;
        break;
      default:
        debugPrint(
          "data_managment.dart = > updateCounter => Geçersiz key: $dataName",
        );
        return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(dataName, dataValue);
  } catch (e, stackTrace) {
    debugPrint(
      "data_managment.dart => updateCounter => Error: $e\n$stackTrace",
    );
  }
}

// reset

Future<void> resetCounter(String dataName) async {
  try {
    await updateCounter(dataName, 0);
  } catch (e, stackTrace) {
    debugPrint("data_managment.dart => resetCounter => Error: $e\n$stackTrace");
  }
}
