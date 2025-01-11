import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/client_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:flutter_proyecto_ft/presentation/providers/product_provider.dart';

class OrderForm extends ConsumerStatefulWidget {
  final void Function(OrderModel order) onSave;

  const OrderForm({super.key, required this.onSave});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends ConsumerState<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _friendlyIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _invoiceNumberController = TextEditingController();
  final TextEditingController _installationDescriptionController = TextEditingController();
  final TextEditingController _maintenanceDescriptionController = TextEditingController();
  final TextEditingController _scheduleDateController = TextEditingController();
  final TextEditingController _completionDateController = TextEditingController();
  bool _isInstallation = false;
  bool _isMaintenance = false;
  ClientModel? _selectedClient;
  ProductModel? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientListProvider);
    final products = ref.watch(productListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<ClientModel>(
                decoration: const InputDecoration(labelText: 'Cliente'),
                items: clients.when(
                  data: (clients) => clients.map((client) {
                    return DropdownMenuItem<ClientModel>(
                      value: client,
                      child: Text('${client.names} ${client.lastNames}'),
                    );
                  }).toList(),
                  loading: () => [],
                  error: (err, stack) => [],
                ),
                onChanged: (ClientModel? value) {
                  setState(() {
                    _selectedClient = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _friendlyIdController,
                decoration: const InputDecoration(labelText: 'Friendly ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text = pickedDate.toIso8601String();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _invoiceNumberController,
                decoration: const InputDecoration(labelText: 'Número de Factura (opcional)'),
              ),
              CheckboxListTile(
                title: const Text('Instalación'),
                value: _isInstallation,
                onChanged: (bool? value) {
                  setState(() {
                    _isInstallation = value ?? false;
                    if (_isInstallation) _isMaintenance = false;
                  });
                },
              ),
              if (_isInstallation) ...[
                DropdownButtonFormField<ProductModel>(
                  decoration: const InputDecoration(labelText: 'Producto'),
                  items: products.when(
                    data: (products) => products.map((product) {
                      return DropdownMenuItem<ProductModel>(
                        value: product,
                        child: Text(product.name),
                      );
                    }).toList(),
                    loading: () => [],
                    error: (err, stack) => [],
                  ),
                  onChanged: (ProductModel? value) {
                    setState(() {
                      _selectedProduct = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _installationDescriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción de la Instalación'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _scheduleDateController,
                  decoration: const InputDecoration(labelText: 'Fecha Programada'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _scheduleDateController.text = pickedDate.toIso8601String();
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _completionDateController,
                  decoration: const InputDecoration(labelText: 'Fecha de Finalización (opcional)'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _completionDateController.text = pickedDate.toIso8601String();
                      });
                    }
                  },
                ),
              ],
              CheckboxListTile(
                title: const Text('Mantenimiento'),
                value: _isMaintenance,
                onChanged: (bool? value) {
                  setState(() {
                    _isMaintenance = value ?? false;
                    if (_isMaintenance) _isInstallation = false;
                  });
                },
              ),
              if (_isMaintenance)
                TextFormField(
                  controller: _maintenanceDescriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción del Mantenimiento'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _selectedClient != null) {
                    final installation = _isInstallation
                        ? InstallationModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            order: OrderModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              client: _selectedClient!,
                              friendlyId: _friendlyIdController.text,
                              date: DateTime.parse(_dateController.text),
                              type: 'installation',
                            ),
                            product: _selectedProduct!,
                            scheduleDate: DateTime.parse(_scheduleDateController.text),
                            completionDate: _completionDateController.text.isNotEmpty ? DateTime.parse(_completionDateController.text) : null,
                            notes: _installationDescriptionController.text,
                            status: StatusType.pending,
                          )
                        : null;

                    final maintenance = _isMaintenance
                        ? MaintenanceModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            order: OrderModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              client: _selectedClient!,
                              friendlyId: _friendlyIdController.text,
                              date: DateTime.parse(_dateController.text),
                              type: 'maintenance',
                            ),
                            scheduleDate: DateTime.now().add(const Duration(days: 365)),
                            notes: _maintenanceDescriptionController.text,
                          )
                        : null;

                    final newOrder = OrderModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      client: _selectedClient!,
                      friendlyId: _friendlyIdController.text,
                      date: DateTime.parse(_dateController.text),
                      invoiceNumber: _invoiceNumberController.text.isEmpty ? null : _invoiceNumberController.text,
                      installationRef: installation != null ? FirebaseFirestore.instance.collection('installations').doc(installation.id.toString()) : null,
                      maintenanceRef: maintenance != null ? FirebaseFirestore.instance.collection('maintenances').doc(maintenance.id.toString()) : null,
                      type: _isInstallation ? 'installation' : 'maintenance',
                    );

                    widget.onSave(newOrder);

                    if (installation != null) {
                      await FirebaseFirestore.instance.collection('installations').doc(installation.id.toString()).set(installation.toMap());
                    }

                    if (maintenance != null) {
                      await FirebaseFirestore.instance.collection('maintenances').doc(maintenance.id.toString()).set(maintenance.toMap());
                    }
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
