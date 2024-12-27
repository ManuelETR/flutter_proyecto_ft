import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/installation_provider.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/installation_form.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterInstallationScreen extends ConsumerStatefulWidget {
  static const String name = "register_installation_screen";

  const RegisterInstallationScreen({super.key});

  @override
  _RegisterInstallationScreenState createState() =>
      _RegisterInstallationScreenState();
}

class _RegisterInstallationScreenState
    extends ConsumerState<RegisterInstallationScreen> {
  final _formKey = GlobalKey<FormState>();
  Client? _selectedClient;
  Product? _selectedProduct;
  StatusType? _selectedStatus;
  DateTime? _selectedScheduleDate;
  String? _notes;

  void _saveInstallation() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedClient != null && _selectedProduct != null) {
        final order = OrderC(
          id: DateTime.now().millisecondsSinceEpoch,
          frendlyId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
          date: DateTime.now(),
          client: _selectedClient!,
        );

        final installation = InstallationModel(
          id: DateTime.now().millisecondsSinceEpoch,
          order: OrderModel.fromOrderC(order),
          product: ProductModel(
            id: _selectedProduct!.id,
            name: _selectedProduct!.name,
          ),
          scheduleDate: _selectedScheduleDate,
          notes: _notes,
          status: _selectedStatus ?? StatusType.pending,
        );

        await ref.read(installationProvider).addInstallation(installation);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Instalación guardada con éxito')),
        );

        _formKey.currentState?.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona un cliente y un producto')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Instalación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InstallationFormWidget(
          onOrderChanged: (order) {},
          onProductChanged: (product) {
            setState(() {
              _selectedProduct = product;
            });
          },
          onStatusChanged: (status) {
            setState(() {
              _selectedStatus = status;
            });
          },
          onScheduleDateChanged: (date) {
            setState(() {
              _selectedScheduleDate = date;
            });
          },
          onNotesChanged: (notes) {
            setState(() {
              _notes = notes;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveInstallation,
        child: const Icon(Icons.save),
      ),
    );
  }
}