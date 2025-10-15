import 'package:flutter/material.dart';
import 'package:pomodoro_app/Theme/colors.dart';

class AppNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: AppColors.second,
      indicatorColor: AppColors.fourth,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.play_arrow_rounded, color: AppColors.second),
          icon: Icon(Icons.play_arrow_outlined, color: AppColors.fourth),
          label: 'Game',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.timer_rounded, color: AppColors.second),
          icon: Icon(Icons.timer_outlined, color: AppColors.fourth),
          label: 'Timer',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.query_stats, color: AppColors.second),
          icon: Icon(Icons.query_stats, color: AppColors.fourth),
          label: 'Stats',
        ),
      ],
    );
  }
}
