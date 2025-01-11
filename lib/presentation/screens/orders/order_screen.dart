import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/presentation/providers/order_provider.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const String name = "order_screen";

  const OrderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        return _OrderTile(order: order);
      },
    );
  }
}

class _OrderTile extends StatelessWidget {
  final OrderModel order;

  const _OrderTile({required this.order});

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
            Text('Fecha: ${order.date.toLocal()}'),
            Text('Cliente: ${order.client.names} ${order.client.lastNames}'),
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Orden con ID $orderId eliminada')),
      );
      // Eliminar orden del estado
      // ignore: use_build_context_synchronously
      final ref = ProviderScope.containerOf(context);
      ref.read(orderRepositoryProvider).deleteOrder(orderId);
    }
  }
}