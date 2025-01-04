import 'package:flutter_proyecto_ft/domain/entities/order.dart';

class Maintenance {
  final int id;
  final OrderC order;
  final DateTime scheduleDate;
  DateTime? completionDate;
  String? notes;

  Maintenance({
    required this.id,
    required this.order,
    required this.scheduleDate,
    this.completionDate,
    this.notes,
  });
}