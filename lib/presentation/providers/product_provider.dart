import 'package:flutter_proyecto_ft/data/services/products/product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return FirestoreProductService();
});

final productListProvider = StreamProvider<List<ProductModel>>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.getProductsStream();
});