import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/maintenance_provider.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/maintenance_form.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterMaintenanceScreen extends ConsumerStatefulWidget {
  static const String name = "register_maintenance_screen";

  const RegisterMaintenanceScreen({super.key});

  @override
  _RegisterMaintenanceScreenState createState() =>
      _RegisterMaintenanceScreenState();
}

class _RegisterMaintenanceScreenState
    extends ConsumerState<RegisterMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  Client? _selectedClient;
  Product? _selectedProduct;
  StatusType? _selectedStatus;
  DateTime? _selectedScheduleDate;
  String? _notes;

  void _saveMaintenance() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedClient != null && _selectedProduct != null) {
        final order = OrderC(
          id: DateTime.now().millisecondsSinceEpoch,
          frendlyId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
          date: DateTime.now(),
          client: _selectedClient!,
        );

        final maintenance = MaintenanceModel(
          id: DateTime.now().millisecondsSinceEpoch,
          order: OrderModel.fromOrderC(order),
          scheduleDate: _selectedScheduleDate,
          notes: _notes,
        );

        await ref.read(maintenanceProvider).addMaintenance(maintenance);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mantenimiento guardado con éxito')),
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
        title: const Text('Registro de Mantenimiento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaintenanceFormWidget(
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
        onPressed: _saveMaintenance,
        child: const Icon(Icons.save),
      ),
    );
  }
}