import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/domain/entities/address.dart';

class OrderModel {
  final int id;
  final int clientId;
  final String friendlyId;
  final DateTime date;
  final String? invoiceNumber;

  OrderModel({
    required this.id,
    required this.clientId,
    required this.friendlyId,
    required this.date,
    this.invoiceNumber,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'],
      clientId: data['clientId'],
      friendlyId: data['friendlyId'],
      date: (data['date'] as Timestamp).toDate(),
      invoiceNumber: data['invoiceNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'friendlyId': friendlyId,
      'date': date,
      'invoiceNumber': invoiceNumber,
    };
  }

  // Convertir OrderC a OrderModel
  factory OrderModel.fromOrderC(OrderC order) {
    return OrderModel(
      id: order.id,
      clientId: order.client.id,
      friendlyId: order.frendlyId,
      date: order.date,
      invoiceNumber: order.invoiceNumber,
    );
  }

  // Convertir OrderModel a OrderC
  OrderC toOrderC() {
    return OrderC(
      id: id,
      client: Client(
        id: clientId,
        names: '', // Aquí debes obtener el nombre del cliente
        lastNames: '', // Aquí debes obtener el apellido del cliente
        address: Address(
          street: '', // Aquí debes obtener la dirección del cliente
          number: '', // Aquí debes obtener el número de la dirección del cliente
          neighborhood: '', // Aquí debes obtener el vecindario del cliente
        ),
      ),
      frendlyId: friendlyId,
      date: date,
      invoiceNumber: invoiceNumber,
    );
  }
}