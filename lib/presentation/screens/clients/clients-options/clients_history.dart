import 'package:flutter/material.dart';

class ClientsHistoryScreen extends StatelessWidget {
  static const String name = "clients_history_screen";

  const ClientsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: const Center(
        child: Text('Aquí se muestra el historial de trabajos.'),
      ),
    );
  }
}
