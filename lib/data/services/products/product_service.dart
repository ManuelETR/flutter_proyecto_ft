import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear un nuevo producto
  Future<void> addProduct(Product product) async {
    try {
      await _db.collection('products').doc(product.id.toString()).set({
        'name': product.name,
        'description': product.description,
        'brand': product.brand,
        'details': product.details,
        'photo': product.photo,
      });
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  // Obtener un producto por ID
  Future<Product?> getProduct(int id) async {
    try {
      DocumentSnapshot snapshot = await _db.collection('products').doc(id.toString()).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return Product(
          id: id,
          name: data['name'],
          description: data['description'],
          brand: data['brand'],
          details: Map<String, String>.from(data['details'] ?? {}),
          photo: data['photo'],
        );
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }
}
