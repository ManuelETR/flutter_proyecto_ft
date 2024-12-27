// data/models/address_model.dart
import 'package:flutter_proyecto_ft/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required super.street,
    required super.number,
    required super.neighborhood,
    super.postalCode,
  });

  // Convertir el modelo de datos a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'postalCode': postalCode,
    };
  }

  // Convertir de un documento de Firestore a AddressModel
  factory AddressModel.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) {
      throw Exception("Address data is null");
    }
    return AddressModel(
      street: data['street'] ?? '',
      number: data['number'] ?? '',
      neighborhood: data['neighborhood'] ?? '',
      postalCode: data['postalCode'],
    );
  }
}
