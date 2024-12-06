import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {

  static const String name = 'products_screen';

  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(title: const Text('ProductScreen')),

      body: const Placeholder(),    
    );
  }
}
