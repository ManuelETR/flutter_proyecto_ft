import 'package:cloud_firestore/cloud_firestore.dart';

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

  toOrderC() {}
}