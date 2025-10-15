import 'package:flutter/material.dart';
import 'package:pomodoro_app/Theme/colors.dart';

class naviBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const naviBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: AppColors.fourth,
      backgroundColor: AppColors.second,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.play_arrow_rounded, color: AppColors.second),
          icon: Icon(Icons.play_arrow_outlined, color: AppColors.fourth),
          label: 'Challenge',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.timer_rounded, color: AppColors.second),
          icon: Icon(Icons.timer_outlined, color: AppColors.fourth),
          label: 'Tİmer',
        ),
        NavigationDestination(
          selectedIcon: (Icon(Icons.query_stats, color: AppColors.second)),
          icon: Icon(Icons.query_stats, color: AppColors.fourth),
          label: 'Statistic',
        ),
      ],
    );
  }
}
