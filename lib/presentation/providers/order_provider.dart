import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/services/order/order_service.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = ChangeNotifierProvider((ref) => OrderProvider());

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  Future<void> fetchOrders() async {
    _orders = await _orderService.getOrders();
    notifyListeners();
  }

  Future<void> addOrder(OrderC order) async {
    await _orderService.addOrder(order);
    _orders.add(OrderModel.fromOrderC(order));
    notifyListeners();
  }

  Future<void> updateOrder(OrderC order) async {
    await _orderService.updateOrder(order);
    int index = _orders.indexWhere((ord) => ord.id == order.id);
    if (index != -1) {
      _orders[index] = OrderModel.fromOrderC(order);
      notifyListeners();
    }
  }

  Future<void> deleteOrder(int id) async {
    await _orderService.deleteOrder(id);
    _orders.removeWhere((ord) => ord.id == id);
    notifyListeners();
  }
}