import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/order_provider.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/order_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';

class RegisterOrderScreen extends ConsumerStatefulWidget {
  static const String name = "register_order_screen";

  const RegisterOrderScreen({super.key});

  @override
  _RegisterOrderScreenState createState() => _RegisterOrderScreenState();
}

class _RegisterOrderScreenState extends ConsumerState<RegisterOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  void _saveOrder(OrderC order) async {
    await ref.read(orderProvider).addOrder(order);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Orden guardada con éxito')),
    );

    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Orden'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrderFormWidget(
          formKey: _formKey,
          onSave: _saveOrder,
        ),
      ),
    );
  }
}