import 'package:flutter_proyecto_ft/domain/entities/alert.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel extends Alert {
  AlertModel({
    required int id,
    required OrderModel order,
    bool isIgnored = false,
    DateTime? snoozeDate,
  }) : super(
          id: id,
          order: order.toOrderC(),
          isIgnored: isIgnored,
          snoozeDate: snoozeDate,
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