import 'package:flutter/material.dart';

class ConfigurationScreen extends StatelessWidget {

  static const String name = "configuration_screen";

  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('ConfigurationScreen')),

      body: const Placeholder(),    
    );
  }
}
