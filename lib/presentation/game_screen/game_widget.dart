import 'package:flutter/material.dart';
import 'dart:math';

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

  bool _canAttack = true;
  final int _attackCooldownMs = 200;

  final ValueNotifier<int> healthNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> damageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<Color> colorNotifier = ValueNotifier<Color>(Colors.red);

  int calculateHealth() =>
      (10 + (levelCounter.value * levelCounter.value / 3)).toInt();
  int calculateDamage() => (1 + (expCounter.value / 2)).toInt();

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
    if (!_canAttack) return;
    _canAttack = false;

    _health -= _damage;
    if (_health <= 0) {
      _health = 0;
      updateCounter("level_counter", levelCounter.value + 1).catchError((e) {
        debugPrint("updateCounter hatası: $e");
      });
      _health = calculateHealth();
      _damage = calculateDamage();
      enemyColor = getRandomColor();
      colorNotifier.value = enemyColor;
    }

    healthNotifier.value = _health;
    damageNotifier.value = _damage;

    Future.delayed(Duration(milliseconds: _attackCooldownMs), () {
      _canAttack = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();

    levelCounter.addListener(() {
      _health = calculateHealth();
      healthNotifier.value = _health;

      _damage = calculateDamage();
      damageNotifier.value = _damage;
    });

    expCounter.addListener(() {
      _damage = calculateDamage();
      damageNotifier.value = _damage;
    });
  }

  Future<void> initData() async {
    try {
      await loadLevelCounter();
      await loadExpCounter();
      _damage = calculateDamage();
      _health = calculateHealth();
      enemyColor = getRandomColor();

      healthNotifier.value = _health;
      damageNotifier.value = _damage;
      colorNotifier.value = enemyColor;
    } catch (e, st) {
      debugPrint("game_widget.dart => initData() => Error: $e\n$st");
      _damage = 1;
      _health = 10;
      enemyColor = Colors.red;

      healthNotifier.value = _health;
      damageNotifier.value = _damage;
      colorNotifier.value = enemyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _attack,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<int>(
                valueListenable: healthNotifier,
                builder: (_, health, __) {
                  final maxHealth = calculateHealth();
                  return Container(
                    width: 250 * (health / maxHealth),
                    height: 25,
                    color: Colors.red.shade300,
                    child: Center(child: Text("$health/$maxHealth")),
                  );
                },
              ),
              ValueListenableBuilder<Color>(
                valueListenable: colorNotifier,
                builder: (_, color, __) =>
                    Container(width: 250, height: 250, color: color),
              ),
              ValueListenableBuilder<int>(
                valueListenable: damageNotifier,
                builder: (_, damage, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Level: ${levelCounter.value}"),
                      SizedBox(width: 30),
                      Text("Attack: $damage"),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
