import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';

class OrdersService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getClientOrders(int clientId) async {
    try {
      QuerySnapshot snapshot = await _db.collection('orders').where('clientId', isEqualTo: clientId).get();
      return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching client orders: $e");
      return [];
    }
  }
}