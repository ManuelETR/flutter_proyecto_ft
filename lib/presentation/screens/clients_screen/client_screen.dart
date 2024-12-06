import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {

  static const String name = "client_screen";

  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('ClientScreen')),

      body: const Placeholder(),    
    );
  }
}
