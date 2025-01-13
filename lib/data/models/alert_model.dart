import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel {
  final String id;
  final String orderId;
  final DateTime alertDate;
  final String message;

  AlertModel({
    required this.id,
    required this.orderId,
    required this.alertDate,
    required this.message,
  });

  // Convertir el modelo a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'alertDate': Timestamp.fromDate(alertDate),
      'message': message,
    };
  }

  // Crear un modelo a partir de Firestore
  factory AlertModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return AlertModel(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      alertDate: (data['alertDate'] as Timestamp).toDate(),
      message: data['message'] ?? '',
    );
  }
}
