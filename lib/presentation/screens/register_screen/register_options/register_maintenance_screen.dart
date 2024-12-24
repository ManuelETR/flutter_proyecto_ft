import 'package:flutter/material.dart';

class RegisterMaintenanceScreen extends StatelessWidget {

  static const String name = "calendar_screen";

  const RegisterMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('MaintenanceScreen')),

      body: const Placeholder(),    
    );
  }
}
