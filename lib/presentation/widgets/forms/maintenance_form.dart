import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenanceFormWidget extends StatefulWidget {
  final ValueChanged<OrderC?>? onOrderChanged;
  final ValueChanged<Product?>? onProductChanged;
  final ValueChanged<StatusType?>? onStatusChanged;
  final ValueChanged<DateTime?>? onScheduleDateChanged;
  final ValueChanged<String?>? onNotesChanged;

  const MaintenanceFormWidget({
    super.key,
    this.onOrderChanged,
    this.onProductChanged,
    this.onStatusChanged,
    this.onScheduleDateChanged,
    this.onNotesChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MaintenanceFormWidgetState createState() => _MaintenanceFormWidgetState();
}

class _MaintenanceFormWidgetState extends State<MaintenanceFormWidget> {
  List<ClientModel> clients = [];
  List<ProductModel> products = [];
  ClientModel? selectedClient;

  @override
  void initState() {
    super.initState();
    _fetchClients();
    _fetchProducts();
  }

  Future<void> _fetchClients() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('clients').get();
    setState(() {
      clients = querySnapshot.docs.map((doc) {
        return ClientModel.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> _fetchProducts() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      products = querySnapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc);
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
            DropdownButtonFormField<ProductModel>(
              decoration: const InputDecoration(
                labelText: 'Producto',
                border: OutlineInputBorder(),
              ),
              items: products.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
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
                    const SnackBar(content: Text('Mantenimiento registrado')),
                  );
                },
                child: const Text('Guardar Mantenimiento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}