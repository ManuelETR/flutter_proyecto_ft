// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/domain/repositories/product_providers.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/forms/product_form.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class RegisterProductScreen extends ConsumerStatefulWidget {
  static const String name = "register_maintenance";

  const RegisterProductScreen({super.key});

  @override
  _RegisterProductScreenState createState() =>
      _RegisterProductScreenState();
}

class _RegisterProductScreenState
    extends ConsumerState<RegisterProductScreen> {
  File? _imageFile;

  void _saveProduct(ProductModel product) async {
    await ref.read(productProvider).addProduct(product, _imageFile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto guardado con éxito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductFormWidget(
          onProductChanged: (product) {
            _saveProduct(product!);
          },
        ),
      ),
    );
  }
}