// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductFormWidget extends StatefulWidget {
  final ValueChanged<ProductModel?>? onProductChanged;

  const ProductFormWidget({
    super.key,
    this.onProductChanged,
  });

  @override
  _ProductFormWidgetState createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  String? _brand;
  final Map<String, String> _details = {};
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _name!,
        description: _description ?? '',
        brand: _brand,
        details: _details,
        photo: null,
      );

      widget.onProductChanged?.call(product);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto guardado con éxito')),
      );

      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de nombre del producto
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del Producto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del producto';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              const SizedBox(height: 16),

              // Campo de descripción del producto
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripción del Producto',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(height: 16),

              // Campo de marca del producto
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Marca del Producto',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _brand = value;
                },
              ),
              const SizedBox(height: 16),

              // Campo de detalles del producto
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Detalles del Producto',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Aquí puedes agregar lógica para manejar múltiples detalles
                  _details['detalle'] = value;
                },
              ),
              const SizedBox(height: 16),

              // Botón para seleccionar imagen
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Seleccionar Imagen'),
              ),
              if (_imageFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.file(_imageFile!),
                ),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProduct,
                  child: const Text('Guardar Producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}