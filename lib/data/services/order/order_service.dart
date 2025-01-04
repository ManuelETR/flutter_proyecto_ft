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
    DocumentSnapshot doc = await _ordersCollection.doc(id).get();
    return OrderModel.fromFirestore(doc);
  }

  Stream<List<OrderModel>> getOrders() {
    return _ordersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
    });
  }

  Future<List<OrderModel>> getClientOrders(int clientId) async {
    QuerySnapshot querySnapshot = await _ordersCollection.where('clientId', isEqualTo: clientId).get();
    return querySnapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }
}