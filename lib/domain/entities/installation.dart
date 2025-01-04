import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';

class Installation {
  final int id;
  final OrderC order;
  final Product product;
  final DateTime scheduleDate;
  DateTime? completionDate;
  String? notes;
  final StatusType status;

  Installation({
    required this.id,
    required this.order,
    required this.product,
    required this.scheduleDate,
    this.completionDate,
    this.notes,
    this.status = StatusType.pending,
  });
}