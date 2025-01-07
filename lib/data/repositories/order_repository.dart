import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/services/order/order_service.dart';

class OrderRepository {
  final OrderService _orderService = OrderService();

  Future<void> addOrder(OrderModel order) async {
    await _orderService.addOrder(order);
  }

  Future<void> updateOrder(String id, OrderModel order) async {
    await _orderService.updateOrder(id, order);
  }

  Future<void> deleteOrder(String id) async {
    await _orderService.deleteOrder(id);
  }

  Future<OrderModel> getOrder(String id) async {
    return await _orderService.getOrder(id);
  }

  Stream<List<OrderModel>> getOrders() {
    return _orderService.getOrders();
  }

  
}