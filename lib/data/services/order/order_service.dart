import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear una nueva orden
  Future<void> addOrder(OrderC order) async {
    try {
      await _db.collection('orders').doc(order.id.toString()).set({
        'id': order.id,
        'clientId': order.client.id,
        'friendlyId': order.friendlyId,
        'date': order.date,
        'invoiceNumber': order.invoiceNumber,
      });
    } catch (e) {
      print("Error adding order: $e");
    }
  }

  // Obtener todas las órdenes
  Future<List<OrderModel>> getOrders() async {
    var querySnapshot = await _db.collection('orders').get();
    return querySnapshot.docs
        .map((doc) => OrderModel.fromFirestore(doc))
        .toList();
  }

  // Actualizar una orden
  Future<void> updateOrder(OrderC order) async {
    try {
      await _db.collection('orders').doc(order.id.toString()).update({
        'clientId': order.client.id,
        'friendlyId': order.friendlyId,
        'date': order.date,
        'invoiceNumber': order.invoiceNumber,
      });
    } catch (e) {
      print("Error updating order: $e");
    }
  }

  // Eliminar una orden
  Future<void> deleteOrder(int id) async {
    try {
      await _db.collection('orders').doc(id.toString()).delete();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

  getClientOrders(int clientId) {}
}