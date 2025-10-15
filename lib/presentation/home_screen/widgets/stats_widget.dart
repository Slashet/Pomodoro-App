import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// Data implementation
import 'package:pomodoro_app/data/work_counter.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  @override
  void initState() {
    super.initState();
    loadCounter();
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
                color: AppColors.second,
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
            Expanded(child: Card(child: SizedBox.expand())),
          ],
        ),
      ),
    );
  }
}
