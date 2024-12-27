import 'package:flutter_proyecto_ft/domain/entities/order.dart';

class Alert {
  final int id;
  final OrderC order;
  bool isIgnored;
  DateTime? snoozeDate;

  Alert({
    required this.id,
    required this.order,
    this.isIgnored = false,
    this.snoozeDate,
  });
}