// data/models/product_model.dart
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    super.description,
    super.brand,
    super.details,
    super.photo,
  });

  // Convertir el modelo de datos a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'details': details,
      'photo': photo,
    };
  }

  // Convertir de un documento de Firestore a ProductModel
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      description: data['description'],
      brand: data['brand'],
      details: data['details'] != null
          ? Map<String, String>.from(data['details'])
          : null,
      photo: data['photo'],
    );
  }
}
