import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/data/services/clients/clients_service.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/client_form.dart';
import 'package:go_router/go_router.dart';

class ClientDetailScreen extends StatefulWidget {
  static const String name = "client_detail_screen";

  final ClientModel client;

  const ClientDetailScreen({super.key, required this.client});

  @override
  // ignore: library_private_types_in_public_api
  _ClientDetailScreenState createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  Future<void> _refreshClient() async {
    final updatedClient = await ClientService().getClient(widget.client.id);
    if (updatedClient != null) {
      setState(() {
        widget.client.names = updatedClient.names;
        widget.client.lastNames = updatedClient.lastNames;
        widget.client.tel = updatedClient.tel;
        widget.client.address = updatedClient.address;
      });
    }
  }

  void _editClient(ClientModel client) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: ClientForm(
              existingClient: client,
              onSave: (updatedClient) async {
                await ClientService().addClient(updatedClient);
                await _refreshClient(); // Hacer refresh después de guardar
              },
              onClientCreated: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Información del cliente actualizada')),
                );
              },
            ),
          ),
        );
      },
    );
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editClient(widget.client),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.client.names} ${widget.client.lastNames}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 16.0),
            _buildInfoRow('ID:', widget.client.id.toString()),
            _buildInfoRow('Nombre:', '${widget.client.names} ${widget.client.lastNames}'),
            _buildInfoRow('Teléfono:', widget.client.tel ?? 'No disponible'),
            _buildInfoRow(
              'Dirección:',
              '${widget.client.address.street}, ${widget.client.address.number}, '
              '${widget.client.address.neighborhood}, ${widget.client.address.postalCode}',
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
