import 'package:flutter/material.dart';

// color implementation
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            infoCard(innerText: "Work Counter", innerDataNotifier: workCounter),
            Divider(),
            infoCard(
              innerText: "Level Counter",
              innerDataNotifier: levelCounter,
            ),
            Divider(),
            infoCard(innerText: "Exp Counter", innerDataNotifier: expCounter),
            Divider(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.fourth,
                ),
                onPressed: () async {
                  await resetCounter("work_counter");
                  await resetCounter("level_counter");
                  await resetCounter("exp_counter");
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
          ],
        ),
      ),
    );
  }
}

class infoCard extends StatefulWidget {
  final String innerText;
  final ValueNotifier<int> innerDataNotifier;

  const infoCard({
    super.key,
    required this.innerText,
    required this.innerDataNotifier,
  });

  @override
  State<infoCard> createState() => _infoCardState();
}

class _infoCardState extends State<infoCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.third,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Text(
                    widget.innerText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.fourth,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: widget.innerDataNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.fourth,
                          fontSize: 50,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
