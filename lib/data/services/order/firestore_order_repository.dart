import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/services/alert/alert_service.dart';
import 'package:flutter_proyecto_ft/data/services/order/order_service.dart';
import 'package:flutter_proyecto_ft/domain/repositories/order_repository.dart';

class FirestoreOrderRepository implements OrderRepository {
  final OrderService _orderService = OrderService();
  final AlertService _alertService = AlertService();

  @override
  Future<void> addOrder(OrderModel order) async {
    await _orderService.addOrder(order);

    // Crear una alerta para la orden
    await _alertService.createAlert(
      order.id,
      order.date.add(const Duration(days: 7)), // Alerta 7 días después
      'Revisar la orden ${order.friendlyId}',
    );
  }

  @override
  Future<void> updateOrder(String id, OrderModel order) async {
    await _orderService.updateOrder(id, order);

    // Actualizar alerta asociada (opcional)
    // Aquí puedes definir lógica adicional si se requiere
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
  return FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc))
          .toList());
}
  
  @override
  Future<List<OrderModel>> getClientOrders(int clientId) {
    // TODO: implement getClientOrders
    throw UnimplementedError();
  }
}