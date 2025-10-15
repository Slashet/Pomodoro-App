import 'package:flutter/material.dart';

// Color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// Data implementation
import 'package:pomodoro_app/data/data_managment.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            // Reset Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.fourth,
                ),
                onPressed: () async {
                  try {
                    await resetCounter("work_counter");
                    await resetCounter("level_counter");
                    await resetCounter("exp_counter");
                    await resetCounter(
                      "streak_counter",
                    ); // Eğer streakCounter varsa
                  } catch (e, st) {
                    debugPrint("Reset hatası: $e\n$st");
                  }
                },
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: AppColors.second,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(height: 24),
            // InfoCards
            InfoCard(innerText: "Work Counter", innerDataNotifier: workCounter),
            const Divider(),
            InfoCard(
              innerText: "Level Counter",
              innerDataNotifier: levelCounter,
            ),
            const Divider(),
            InfoCard(innerText: "Exp Counter", innerDataNotifier: expCounter),
            const Divider(),
            InfoCard(innerText: "Streak", innerDataNotifier: streakCounter),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String innerText;
  final ValueNotifier<int> innerDataNotifier;

  const InfoCard({
    super.key,
    required this.innerText,
    required this.innerDataNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.third,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 100, // Sabit yükseklik
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                innerText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.fourth,
                  fontSize: 24,
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: innerDataNotifier,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.fourth,
                      fontSize: 24,
                    ),
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
