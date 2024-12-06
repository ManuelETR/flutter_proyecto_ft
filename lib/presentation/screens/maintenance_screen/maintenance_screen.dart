import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {

  static const String name = "maintenance_screen";

  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('MaintenanceScreen')),

      body: const Placeholder(),    
    );
  }
}
