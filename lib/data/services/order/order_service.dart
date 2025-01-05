import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';

class OrderService {
  final CollectionReference _ordersCollection = FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder(OrderModel order) async {
    await _ordersCollection.add(order.toMap());
  }

  Future<void> updateOrder(String id, OrderModel order) async {
    await _ordersCollection.doc(id).update(order.toMap());
  }

  Future<void> deleteOrder(String id) async {
    await _ordersCollection.doc(id).delete();
  }

Future<OrderModel> getOrder(String id) async {
    try {
      DocumentSnapshot doc = await _ordersCollection.doc(id).get();
      print('Documento obtenido: ${doc.data()}');
      return OrderModel.fromFirestore(doc);
    } catch (e) {
      print('Error al obtener la orden: $e');
      rethrow;
    }
  }

  Stream<List<OrderModel>> getOrders() {
    try {
      return _ordersCollection.snapshots().map((snapshot) {
        print('Documentos obtenidos: ${snapshot.docs.length}');
        return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
      });
    } catch (e) {
      print('Error al obtener las órdenes: $e');
      rethrow;
    }
  }

  Future<List<OrderModel>> getClientOrders(int clientId) async {
    QuerySnapshot querySnapshot = await _ordersCollection.where('clientId', isEqualTo: clientId).get();
    return querySnapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }
}