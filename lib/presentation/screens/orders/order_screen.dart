// En OrderScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/presentation/providers/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const String name = "order_screen";

  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  String selectedType = 'installation';

  @override
  Widget build(BuildContext context) {
    final filteredOrdersAsync = ref.watch(filteredOrdersProvider(selectedType));

    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          value: selectedType,
          items: const [
            DropdownMenuItem(value: 'installation', child: Text('Instalaciones')),
            DropdownMenuItem(value: 'maintenance', child: Text('Mantenimientos')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedType = value);
            }
          },
        ),
      ),
      body: filteredOrdersAsync.when(
        data: (orders) {
          if (orders.isEmpty) return const Center(child: Text('No hay órdenes disponibles.'));
          return _OrderListView(orders: orders);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _OrderListView extends StatelessWidget {
  final List<OrderModel> orders;

  const _OrderListView({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return FutureBuilder<ClientModel>(
          future: _fetchClient(order.client.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ListTile(
                title: Text('Cargando cliente...'),
                subtitle: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const ListTile(
                title: Text('Error al cargar cliente'),
                subtitle: Text('No se pudo obtener información del cliente'),
              );
            }

            final client = snapshot.data!;
            return _OrderTile(order: order, clientName: "${client.names} ${client.lastNames}");
          },
        );
      },
    );
  }

  Future<ClientModel> _fetchClient(int clientId) async {
    final doc = await FirebaseFirestore.instance.collection('clients').doc(clientId.toString()).get();
    if (!doc.exists) throw Exception('Cliente no encontrado');
    return ClientModel.fromFirestore(doc);
  }
}

class _OrderTile extends StatelessWidget {
  final OrderModel order;
  final String clientName;

  const _OrderTile({required this.order, required this.clientName});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      child: ListTile(
        leading: const Icon(Icons.receipt_long, size: 30),
        title: Text(
          'Orden ${order.friendlyId}',
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.primary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${DateFormat('dd/MM/yyyy').format(order.date)}'),
            Text('Cliente: $clientName'),
            if (order.invoiceNumber != null)
              Text('Factura: ${order.invoiceNumber}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                context.goNamed(
                  'order-detail',
                  pathParameters: {'id': order.id.toString()},
                  extra: order,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteOrder(context, order.id.toString()),
            ),
          ],
        ),
        onTap: () {
          context.goNamed(
            'order-detail',
            pathParameters: {'id': order.id.toString()},
            extra: order,
          );
        },
      ),
    );
  }

  void _deleteOrder(BuildContext context, String orderId) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de que deseas eliminar esta orden?'),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Orden con ID $orderId eliminada')),
      );
      final ref = ProviderScope.containerOf(context);
      ref.read(orderRepositoryProvider).deleteOrder(orderId);
    }
  }
}
