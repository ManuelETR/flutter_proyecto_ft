import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/services/order/order_service.dart';
import 'package:go_router/go_router.dart';

class ClientDetailScreen extends StatelessWidget {
  final ClientModel client;

  const ClientDetailScreen({Key? key, required this.client}) : super(key: key);

  Future<List<OrderModel>> fetchClientOrders(int clientId) async {
    return await OrdersService().getClientOrders(clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Cliente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/clients'), // Navega explícitamente a la ruta de clientes
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${client.names} ${client.lastNames}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 16.0),
            _buildInfoRow('ID:', client.id.toString()),
            _buildInfoRow('Nombre:', '${client.names} ${client.lastNames}'),
            _buildInfoRow('Teléfono:', client.tel ?? 'No disponible'),
            _buildInfoRow('Dirección:', '${client.address.street}, ${client.address.number}, ${client.address.neighborhood}, ${client.address.postalCode}'),
            const SizedBox(height: 24.0),
            Text(
              'Órdenes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8.0),
            FutureBuilder<List<OrderModel>>(
              future: fetchClientOrders(client.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final orders = snapshot.data!;
                  if (orders.isEmpty) {
                    return const Center(child: Text('No hay órdenes para este cliente.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Orden #${orders[index].friendlyId}'),
                          subtitle: Text('Fecha: ${orders[index].date}\nNúmero de Factura: ${orders[index].invoiceNumber ?? 'No disponible'}'),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No hay órdenes para este cliente.'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}