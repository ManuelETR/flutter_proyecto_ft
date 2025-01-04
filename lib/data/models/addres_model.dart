import 'package:flutter_proyecto_ft/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required super.street,
    required super.number,
    required super.neighborhood,
    required super.postalCode,
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

  // Convertir de un mapa de Firestore a AddressModel
  factory AddressModel.fromFirestore(Map<String, dynamic> data) {
    return AddressModel(
      street: data['street'] ?? '',
      number: data['number'] ?? '',
      neighborhood: data['neighborhood'] ?? '',
      postalCode: data['postalCode'] ?? '',
    );
  }

  // Convertir Address a AddressModel
  factory AddressModel.fromAddress(Address address) {
    return AddressModel(
      street: address.street,
      number: address.number,
      neighborhood: address.neighborhood,
      postalCode: address.postalCode,
    );
  }

  // Convertir AddressModel a Address
  Address toAddress() {
    return Address(
      street: street,
      number: number,
      neighborhood: neighborhood,
      postalCode: postalCode,
    );
  }
}