import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<OrderC> onSave;

  const OrderFormWidget({
    Key? key,
    required this.formKey,
    required this.onSave,
  }) : super(key: key);

  @override
  _OrderFormWidgetState createState() => _OrderFormWidgetState();
}

class _OrderFormWidgetState extends State<OrderFormWidget> {
  List<ClientModel> clients = [];
  ClientModel? _selectedClient;
  DateTime? _selectedDate;
  String? _invoiceNumber;

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

  void _saveForm() {
    if (widget.formKey.currentState?.validate() ?? false) {
      if (_selectedClient != null) {
        final order = OrderC(
          id: DateTime.now().millisecondsSinceEpoch,
          friendlyId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
          date: _selectedDate ?? DateTime.now(),
          client: _selectedClient!,
          invoiceNumber: _invoiceNumber, frendlyId: '',
        );

        widget.onSave(order);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona un cliente')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
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
                    _selectedClient = client;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Selector de fecha
              GestureDetector(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate != null
                            ? _selectedDate!.toLocal().toString().split(' ')[0]
                            : 'Seleccionar fecha',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de número de factura
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Número de Factura',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _invoiceNumber = value;
                },
              ),
              const SizedBox(height: 16),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Guardar Orden'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}