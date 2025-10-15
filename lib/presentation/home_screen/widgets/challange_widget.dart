import 'package:flutter/material.dart';

// color implementation
import 'package:pomodoro_app/Theme/colors.dart';

class ChallangeWidget extends StatefulWidget {
  const ChallangeWidget({super.key});

  @override
  State<ChallangeWidget> createState() => _ChallangeWidgetState();
}

class _ChallangeWidgetState extends State<ChallangeWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("challangelar burada gözükücek"));
  }
}
