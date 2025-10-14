import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

// widget implementation
import 'package:pomodoro_app/presentation/home_screen/widgets/timer_widget.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.first,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person_sharp),
            ),
          ],
        ),
        body: MyWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
