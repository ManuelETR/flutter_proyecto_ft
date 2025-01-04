import 'package:flutter_proyecto_ft/data/models/product_model.dart';

abstract class ProductRepository {
  Future<void> createProduct(ProductModel product);
  Future<List<ProductModel>> getProducts();
  Stream<List<ProductModel>> getProductsStream(); // Agregar este método
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}