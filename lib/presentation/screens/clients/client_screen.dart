import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/presentation/providers/client_list_provider.dart';

class ClientScreen extends ConsumerWidget {
  static const String name = "client_screen";

  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientListAsync = ref.watch(clientListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'), // Navega explícitamente a la ruta de Home
        ),
        title: const Text(
          'Clientes y Trabajos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.goNamed('clients_history');
            },
          ),
          IconButton(
            icon: const Icon(Icons.pending_actions),
            onPressed: () {
              context.goNamed('clients_pending');
            },
          ),
        ],
      ),
      body: clientListAsync.when(
        data: (clients) {
          if (clients.isEmpty) {
            return const Center(child: Text('No hay clientes disponibles.'));
          }
          return _ClientListView(clients: clients);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _ClientListView extends StatelessWidget {
  final List<ClientModel> clients;

  const _ClientListView({required this.clients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return _ClientTile(client: client);
      },
    );
  }
}

class _ClientTile extends StatelessWidget {
  final ClientModel client;

  const _ClientTile({required this.client});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.person, size: 30),
        title: Text(
          '${client.names} ${client.lastNames}',
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary),
        ),
        subtitle: Text(client.tel ?? 'Sin teléfono'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteClient(context, client.id),
        ),
        onTap: () {
          context.goNamed(
            'clients-detail',
            pathParameters: {'id': client.id.toString()}, // Pasa el parámetro id
            extra: client, // Pasa el objeto client directamente
          );
        },
      ),
    );
  }

  void _deleteClient(BuildContext context, int clientId) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content:
            const Text('¿Estás seguro de que deseas eliminar este cliente?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente con ID $clientId eliminado')),
      );
      // Eliminar cliente del estado
      // ignore: use_build_context_synchronously
      final ref = ProviderScope.containerOf(context);
      ref.read(clientListProvider.notifier).removeClient(clientId);
    }
  }
}