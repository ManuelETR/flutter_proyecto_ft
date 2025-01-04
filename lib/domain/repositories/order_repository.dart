import 'package:flutter_proyecto_ft/data/models/order_model.dart';

abstract class OrderRepository {
  Future<void> addOrder(OrderModel order);
  Future<void> updateOrder(String id, OrderModel order);
  Future<void> deleteOrder(String id);
  Future<OrderModel> getOrder(String id);
  Stream<List<OrderModel>> getOrders();
  Future<List<OrderModel>> getClientOrders(int clientId);
}