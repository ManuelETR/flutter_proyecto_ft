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
      id: data['id'],
      name: data['name'],
      description: data['description'],
      brand: data['brand'],
      details: data['details'] != null ? Map<String, String>.from(data['details']) : null,
      photo: data['photo'],
    );
  }

  // Convertir Product a ProductModel
  factory ProductModel.fromProduct(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      brand: product.brand,
      details: product.details,
      photo: product.photo,
    );
  }

  // Convertir ProductModel a Product
  Product toProduct() {
    return Product(
      id: id,
      name: name,
      description: description,
      brand: brand,
      details: details,
      photo: photo,
    );
  }
}