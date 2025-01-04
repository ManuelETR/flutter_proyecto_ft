import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/data/services/products/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

class ProductProvider with ChangeNotifier {
  final FirestoreProductService _productService = FirestoreProductService();
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    _products = await _productService.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product, File? imageFile) async {
    await _productService.createProduct(product);
    _products.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product) async {
    await _productService.updateProduct(product);
    int index = _products.indexWhere((prd) => prd.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await _productService.deleteProduct(id);
    _products.removeWhere((prd) => prd.id == id);
    notifyListeners();
  }
}