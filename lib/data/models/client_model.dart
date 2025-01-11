import 'package:flutter_proyecto_ft/data/models/addres_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.names,
    required super.lastNames,
    required AddressModel super.address,
    super.tel,
    required super.orderIds,
  });

  // Convertir el modelo a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'names': names,
      'lastNames': lastNames,
      'tel': tel,
      'address': (address as AddressModel).toMap(),
      'orderIds': orderIds,
    };
  }

  // Crear un ClientModel desde un documento de Firestore
  factory ClientModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return ClientModel(
      id: int.tryParse(doc.id) ?? 0,
      names: data['names'] ?? '',
      lastNames: data['lastNames'] ?? '',
      tel: data['tel'],
      address: AddressModel.fromFirestore(data['address'] as Map<String, dynamic>),
      orderIds: List<String>.from(data['orderIds'] ?? []),
    );
  }

  // Crear un ClientModel desde un objeto Client
  factory ClientModel.fromClient(Client client) {
    return ClientModel(
      id: client.id,
      names: client.names,
      lastNames: client.lastNames,
      tel: client.tel,
      address: AddressModel.fromAddress(client.address),
      orderIds: client.orderIds,
    );
  }

  // Convertir ClientModel a Client
  Client toClient() {
    return Client(
      id: id,
      names: names,
      lastNames: lastNames,
      tel: tel,
      address: (address as AddressModel).toAddress(),
      orderIds: orderIds,
    );
  }
}
