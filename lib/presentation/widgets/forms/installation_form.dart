import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/domain/entities/address.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstallationFormWidget extends StatefulWidget {
  final ValueChanged<OrderC?>? onOrderChanged;
  final ValueChanged<Product?>? onProductChanged;
  final ValueChanged<StatusType?>? onStatusChanged;
  final ValueChanged<DateTime?>? onScheduleDateChanged;
  final ValueChanged<String?>? onNotesChanged;

  const InstallationFormWidget({
    Key? key,
    this.onOrderChanged,
    this.onProductChanged,
    this.onStatusChanged,
    this.onScheduleDateChanged,
    this.onNotesChanged,
  }) : super(key: key);

  @override
  _InstallationFormWidgetState createState() => _InstallationFormWidgetState();
}

class _InstallationFormWidgetState extends State<InstallationFormWidget> {
  List<ClientModel> clients = [];
  ClientModel? selectedClient;

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('clients').get();
    setState(() {
      clients = querySnapshot.docs.map((doc) {
        return ClientModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown para seleccionar el cliente
            DropdownButtonFormField<ClientModel>(
              decoration: const InputDecoration(
                labelText: 'Cliente',
                border: OutlineInputBorder(),
              ),
              items: clients.map((client) {
                return DropdownMenuItem(
                  value: client,
                  child: Text(client.names),
                );
              }).toList(),
              onChanged: (client) {
                setState(() {
                  selectedClient = client;
                });
              },
            ),
            const SizedBox(height: 16),

            // Dropdown para seleccionar el producto
            DropdownButtonFormField<Product>(
              decoration: const InputDecoration(
                labelText: 'Producto',
                border: OutlineInputBorder(),
              ),
              items: [
                // Aquí debes reemplazar con datos reales
                DropdownMenuItem(
                  value: Product(id: 1, name: 'Aire Acondicionado'),
                  child: const Text('Aire Acondicionado'),
                ),
                DropdownMenuItem(
                  value: Product(id: 2, name: 'Calefactor'),
                  child: const Text('Calefactor'),
                ),
              ],
              onChanged: widget.onProductChanged,
            ),
            const SizedBox(height: 16),

            // Dropdown para seleccionar el estado
            DropdownButtonFormField<StatusType>(
              decoration: const InputDecoration(
                labelText: 'Estado',
                border: OutlineInputBorder(),
              ),
              items: StatusType.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.toString().split('.').last),
                );
              }).toList(),
              onChanged: widget.onStatusChanged,
            ),
            const SizedBox(height: 16),

            // Selector de fecha para la programación
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                widget.onScheduleDateChanged?.call(selectedDate);
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha Programada',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seleccionar fecha',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de notas
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notas',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: widget.onNotesChanged,
            ),
            const SizedBox(height: 16),

            // Botón de guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes manejar el evento de guardar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Instalación registrada')),
                  );
                },
                child: const Text('Guardar Instalación'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}