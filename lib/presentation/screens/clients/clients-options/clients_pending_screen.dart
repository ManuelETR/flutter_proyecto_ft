import 'package:flutter/material.dart';

class ClientsPendingScreen extends StatelessWidget {
  static const String name = "clients_pending_screen";

  const ClientsPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabajos Pendientes'),
      ),
      body: const Center(
        child: Text('Aquí se listan los trabajos pendientes.'),
      ),
    );
  }
}