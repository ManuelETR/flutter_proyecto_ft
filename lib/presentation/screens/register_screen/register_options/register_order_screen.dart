import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/order_form.dart';

class RegisterOrderScreen extends ConsumerStatefulWidget {
  static const String name = "register_order_screen";
  const RegisterOrderScreen({super.key});

  @override
  ConsumerState<RegisterOrderScreen> createState() => _RegisterOrderScreenState();
}

class _RegisterOrderScreenState extends ConsumerState<RegisterOrderScreen> {
  void _saveOrder(OrderModel order) {
    ref.read(orderRepositoryProvider).addOrder(order).then((_) {
      // ignore: use_build_context_synchronously
      _showSuccessMessage(context);
    }).catchError((error) {
      // ignore: use_build_context_synchronously
      _showErrorMessage(context, error.toString());
    });
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Orden creada exitosamente')),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $message')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Orden', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
      ),
      body: OrderForm(
        onSave: _saveOrder,
      ),
    );
  }
}