import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/presentation/providers/installation_provider.dart';
import 'package:go_router/go_router.dart';

class OrderListScreen extends ConsumerWidget {
  static const String name = "order_list_screen";
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installations = ref.watch(installationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de Instalaciones',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/calendar'), // Navega explícitamente a la ruta de clientes
        ),
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
      ),
      body: installations.when(
        data: (installations) {
          if (installations.isEmpty) {
            return const Center(child: Text('No hay instalaciones disponibles.'));
          }
          installations.sort((a, b) => a.scheduleDate.compareTo(b.scheduleDate)); // Ordenar por fecha
          return ListView.builder(
            itemCount: installations.length,
            itemBuilder: (context, index) {
              final installation = installations[index];
              return ListTile(
                title: Text('Instalación ${installation.friendlyId}'),
                subtitle: Text('Cliente: ${installation.order.client.names} ${installation.order.client.lastNames}\nFecha: ${installation.scheduleDate}'),
                onTap: () {
                  // Navegar a la pantalla de detalles de la instalación
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          print('Error al cargar las instalaciones: $err');
          return const Center(child: Text('Error al cargar las instalaciones'));
        },
      ),
    );
  }
}