







//PROVISIONAL

import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/installation_form.dart';

class RegisterInstallationScreen extends StatefulWidget {
  static const String name = "register_installation_screen";

  const RegisterInstallationScreen({super.key});

  @override
  State<RegisterInstallationScreen> createState() =>
      _RegisterInstallationScreenState();
}

class _RegisterInstallationScreenState
    extends State<RegisterInstallationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _saveInstallation() {
    if (_formKey.currentState?.validate() ?? false) {
      final newInstallation = {
        "client": _clientController.text,
        "location": _locationController.text,
        "description": _descriptionController.text,
      };

      print("Nueva instalación registrada: $newInstallation");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instalación guardada con éxito')),
      );

      _formKey.currentState?.reset();
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
          formKey: _formKey,
          clientController: _clientController,
          locationController: _locationController,
          descriptionController: _descriptionController,
          onSave: _saveInstallation,
        ),
      ),
    );
  }
}
