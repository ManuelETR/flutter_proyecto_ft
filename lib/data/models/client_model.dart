import 'package:flutter_proyecto_ft/data/models/addres_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.names,
    required super.lastNames,
    required AddressModel super.address,
    super.tel, required name,
  });

  // Convertir el modelo de datos a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'names': names,
      'lastNames': lastNames,
      'tel': tel,
      'address': (address as AddressModel).toMap(),
    };
  }

  // Convertir de un documento de Firestore a ClientModel
  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return ClientModel(
      id: int.tryParse(doc.id) ?? 0,
      names: data['names'] ?? '',
      lastNames: data['lastNames'] ?? '',
      tel: data['tel'],
      address: AddressModel.fromFirestore(data['address'] as Map<String, dynamic>?), name: null,
    );
  }
}