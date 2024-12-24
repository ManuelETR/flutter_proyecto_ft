import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_proyecto_ft/domain/entities/address.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/client.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear una nueva orden
  Future<void> addOrder(OrderC order) async {
    try {
      await _db.collection('orders').doc(order.id.toString()).set({
        'clientId': order.client.id,
        'frendlyId': order.frendlyId,
        'date': order.date,
        'invoiceNumber': order.invoiceNumber,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error adding order: $e");
      }
    }
  }

  // Obtener una orden por ID
  Future<OrderC?> getOrder(int id) async {
    try {
      DocumentSnapshot snapshot = await _db.collection('orders').doc(id.toString()).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return OrderC(
          id: id,
          frendlyId: data['frendlyId'],
          date: (data['date'] as Timestamp).toDate(),
          client: Client(id: data['clientId'], names: '', lastNames: '', address: Address(street: '', number: '', neighborhood: '')),
          invoiceNumber: data['invoiceNumber'],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching order: $e");
      }
    }
    return null;
  }
}
