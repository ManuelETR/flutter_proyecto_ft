import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/addres_model.dart';
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
      'date': Timestamp.fromDate(date),  // Convertir DateTime a Timestamp
      'invoiceNumber': invoiceNumber,
      'installationRef': installationRef,
      'maintenanceRef': maintenanceRef,
      'type': type,
    };
  }

factory OrderModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;

  // Manejar el campo 'date'
  var date = data['date'];
  if (date is String) {
    date = DateTime.tryParse(date);
  } else if (date is Timestamp) {
    date = (date).toDate();
  }

  return OrderModel(
    id: doc.id,
    client: ClientModel(
      id: data['clientId'] is int ? data['clientId'] : 0, // Manejo de clientId
      names: '', // Manejar nombres vacíos si no están presentes
      lastNames: '',
      address: AddressModel.empty(),
      orderIds: [],
    ),
    friendlyId: data['friendlyId'] ?? '', // Manejo de nulos con un valor por defecto
    date: date as DateTime? ?? DateTime.now(), // Manejo de fechas nulas con valor por defecto
    invoiceNumber: data['invoiceNumber'] ?? '', // Manejo de nulos con un valor por defecto
    installationRef: data['installationRef'] is DocumentReference
        ? data['installationRef']
        : null, // Validar el tipo de dato
    maintenanceRef: data['maintenanceRef'] is DocumentReference
        ? data['maintenanceRef']
        : null, // Validar el tipo de dato
    type: data['type'] ?? '', // Manejar nulos con un valor por defecto
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

  // ignore: unrelated_type_equality_checks
  bool get isEmpty => id == 0;

  get length => null;

  // Convertir OrderModel a OrderC
  OrderC toOrderC() {
    return OrderC(
      id: id,
      client: client,
      friendlyId: friendlyId,
      date: date,
      invoiceNumber: invoiceNumber,
      installation: null,
      maintenance: null,
      type: type,
    );
  }
}