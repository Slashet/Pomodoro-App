import 'package:flutter/material.dart';
import 'dart:math';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// Data implementation
import 'package:pomodoro_app/data/data_managment.dart';

class ChallangeWidget extends StatefulWidget {
  const ChallangeWidget({super.key});

  @override
  State<ChallangeWidget> createState() => _ChallangeWidgetState();
}

class _ChallangeWidgetState extends State<ChallangeWidget> {
  int _health = 0;
  int _damage = 0;

  Color enemyColor = Colors.red;

  int calculateHealth() {
    return (10 + (levelCounter.value * levelCounter.value / 3)).toInt();
  }

  int calculateDamage() {
    return (1 + (expCounter.value * 3 / 2)).toInt();
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  void _attack() {
    setState(() {
      _health -= _damage;
      if (_health <= 0) {
        updateCounter("level_counter", levelCounter.value + 1);
        _health = calculateHealth();
        enemyColor = getRandomColor();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadLevelCounter();
    loadExpCounter();

    _damage = calculateDamage();
    _health = calculateHealth();

    enemyColor = getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _attack();
        print("Health:$_health\nLevel:${levelCounter.value}");
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250 * (_health / calculateHealth()),
                height: 25,
                color: Colors.red.shade300,
                child: Center(child: Text("$_health/${calculateHealth()}")),
              ),
              Container(width: 250, height: 250, color: enemyColor),
              Container(
                width: 250 * (expCounter.value / 10),
                height: 25,
                color: Colors.yellow.shade300,
                child: Center(
                  child: Text(
                    "${expCounter.value.toString()}/10",
                    style: TextStyle(color: AppColors.fourth),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
