import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProductService implements ProductRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createProduct(ProductModel product) async {
    var productRef = firestore.collection('products').doc();
    await productRef.set(product.toMap());
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    var querySnapshot = await firestore.collection('products').get();
    return querySnapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    var productRef = firestore.collection('products').doc(product.id.toString());
    await productRef.update(product.toMap());
  }

  @override
  Future<void> deleteProduct(int id) async {
    var productRef = firestore.collection('products').doc(id.toString());
    await productRef.delete();
  }
}