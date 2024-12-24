import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {

  static const String name = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('CalendarScreen')),

      body: const Placeholder(),    
    );
  }
}
