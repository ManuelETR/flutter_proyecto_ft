import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/order_repository.dart';
import 'package:flutter_proyecto_ft/data/services/order/order_service.dart';

class FirestoreOrderRepository implements OrderRepository {
  final OrderService _orderService = OrderService();

  @override
  Future<void> addOrder(OrderModel order) async {
    await _orderService.addOrder(order);
  }

  @override
  Future<void> updateOrder(String id, OrderModel order) async {
    await _orderService.updateOrder(id, order);
  }

  @override
  Future<void> deleteOrder(String id) async {
    await _orderService.deleteOrder(id);
  }

  @override
  Future<OrderModel> getOrder(String id) async {
    return await _orderService.getOrder(id);
  }

  @override
  Stream<List<OrderModel>> getOrders() {
    return _orderService.getOrders();
  }

  Future<List<OrderModel>> getClientOrders(int clientId) async {
    return await _orderService.getClientOrders(clientId);
  }
}