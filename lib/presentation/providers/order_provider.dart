import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/order_repository.dart';
import 'package:flutter_proyecto_ft/data/services/order/firestore_order_repository.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return FirestoreOrderRepository();
});

final orderListProvider = StreamProvider<List<OrderModel>>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return orderRepository.getOrders();
});

final orderProvider = FutureProvider.family<OrderModel, String>((ref, id) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return orderRepository.getOrder(id);
});