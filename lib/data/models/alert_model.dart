import 'package:flutter_proyecto_ft/domain/entities/alert.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel extends Alert {
  AlertModel({
    required super.id,
    required OrderModel order,
    super.isIgnored,
    super.snoozeDate,
  }) : super(
          order: order.toOrderC(),
        );

  // Convertir de Firestore a un objeto AlertModel
  factory AlertModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return AlertModel(
      id: data['id'],
      order: OrderModel.fromFirestore(data['order']),
      isIgnored: data['isIgnored'],
      snoozeDate: (data['snoozeDate'] as Timestamp?)?.toDate(),
    );
  }

  // Convertir un objeto AlertModel a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': (order as OrderModel).toMap(),
      'isIgnored': isIgnored,
      'snoozeDate': snoozeDate,
    };
  }
}