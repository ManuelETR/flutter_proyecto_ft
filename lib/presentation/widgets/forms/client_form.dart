import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/addres_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';// Importa AddressModel

class ClientForm extends ConsumerStatefulWidget {
  final Client? existingClient;
  final void Function(ClientModel client) onSave;
  final VoidCallback onClientCreated;

  const ClientForm({
    super.key,
    this.existingClient,
    required this.onSave,
    required this.onClientCreated,
  });

  @override
  ConsumerState<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends ConsumerState<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingClient != null) {
      _nameController.text = widget.existingClient!.names;
      _lastNameController.text = widget.existingClient!.lastNames;
      _telController.text = widget.existingClient!.tel ?? '';
      _streetController.text = widget.existingClient!.address.street;
      _numberController.text = widget.existingClient!.address.number;
      _neighborhoodController.text = widget.existingClient!.address.neighborhood;
      _postalCodeController.text = widget.existingClient!.address.postalCode.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre(s)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Apellido(s)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(labelText: 'Teléfono (opcional)'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Text(
                'Dirección',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Calle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Número'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(labelText: 'Colonia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postalCodeController,
                decoration: const InputDecoration(labelText: 'Código Postal'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Convertir Address a AddressModel
                    final address = AddressModel(
                      street: _streetController.text,
                      number: _numberController.text,
                      neighborhood: _neighborhoodController.text,
                      postalCode: int.tryParse(_postalCodeController.text) ?? 0,
                    );

                    // Crear un nuevo ClientModel con AddressModel
                    final newClient = ClientModel(
                      id: widget.existingClient?.id ?? DateTime.now().millisecondsSinceEpoch,
                      names: _nameController.text,
                      lastNames: _lastNameController.text,
                      tel: _telController.text.isEmpty ? null : _telController.text,
                      address: address, name: null,
                    );

                    widget.onSave(newClient);  // Llamamos a la función onSave
                    widget.onClientCreated(); // Llamamos a la función para mostrar el mensaje de éxito
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.existingClient == null ? 'Agregar' : 'Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}