import 'package:flutter_proyecto_ft/domain/entities/order.dart';

class Maintenance {
  final int id;
  final OrderC order;
  DateTime? scheduleDate;
  DateTime? completionDate;
  String? notes;

  Maintenance({
    required this.id,
    required this.order,
    this.scheduleDate,
    this.completionDate,
    this.notes,
  });
}