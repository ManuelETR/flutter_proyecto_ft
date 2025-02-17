import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/client_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/presentation/providers/client_list_provider.dart';

class RegisterClientScreen extends ConsumerStatefulWidget {
  const RegisterClientScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends ConsumerState<RegisterClientScreen> {
  void _saveClient(ClientModel client) {
    ref.read(clientListProvider.notifier).addClient(client); // Guardar el cliente en el provider
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente creado exitosamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientForm(
        onSave: _saveClient,
        onClientCreated: () => _showSuccessMessage(context),
      ),
    );
  }
}
