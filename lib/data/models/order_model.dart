import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';

class OrderModel extends OrderC {
  final DocumentReference? installationRef;
  final DocumentReference? maintenanceRef;

  OrderModel({
    required super.id,
    required ClientModel super.client,
    required super.friendlyId,
    required super.date,
    super.invoiceNumber,
    this.installationRef,
    this.maintenanceRef,
    required super.type,
  }) : super(
          installation: null,
          maintenance: null,
        );

  // Convertir el modelo de datos a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': client.id,
      'friendlyId': friendlyId,
      'date': date.toIso8601String(),
      'invoiceNumber': invoiceNumber,
      'installationRef': installationRef,
      'maintenanceRef': maintenanceRef,
      'type': type,
    };
  }

  // Convertir de un documento de Firestore a OrderModel
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      id: int.parse(doc.id),
      client: ClientModel.fromFirestore(data['clientId']),
      friendlyId: data['friendlyId'],
      date: DateTime.parse(data['date']),
      invoiceNumber: data['invoiceNumber'],
      installationRef: data['installationRef'],
      maintenanceRef: data['maintenanceRef'],
      type: data['type'],
    );
  }

  // Convertir OrderC a OrderModel
  factory OrderModel.fromOrderC(OrderC order) {
    return OrderModel(
      id: order.id,
      client: ClientModel.fromClient(order.client),
      friendlyId: order.friendlyId,
      date: order.date,
      invoiceNumber: order.invoiceNumber,
      installationRef: null,
      maintenanceRef: null,
      type: order.type,
    );
  }

  bool get isEmpty => id == 0;

  get length => null;

  // Convertir OrderModel a OrderC
  OrderC toOrderC() {
    return OrderC(
      id: id,
      client: client.toClient(),
      friendlyId: friendlyId,
      date: date,
      invoiceNumber: invoiceNumber,
      installation: null,
      maintenance: null,
      type: type,
    );
  }
}