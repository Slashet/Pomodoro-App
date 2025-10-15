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
    loadWorkCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
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
                            "Work Counter",
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
                            valueListenable: workCounter,
                            builder: (context, workCounter, child) {
                              return Text(
                                '$workCounter',
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
            ),
            Divider(),
            Expanded(
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
                            "Level Counter",
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
                            valueListenable: levelCounter,
                            builder: (context, levelCounter, child) {
                              return Text(
                                '$levelCounter',
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
            ),
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
