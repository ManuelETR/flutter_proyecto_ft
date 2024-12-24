// domain/entities/installation.dart

import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';

class Installation {
  final int id;
  final OrderC order;
  final Product product;
  final StatusType status;  // Ya no tiene valor por defecto
  DateTime? scheduleDate;
  DateTime? completionDate;
  String? notes;

  // Constructor modificado para aceptar status como parámetro opcional
  Installation({
    required this.id, 
    required this.order, 
    required this.product,
    this.scheduleDate,
    this.completionDate,
    this.notes,
    this.status = StatusType.pending,  // Valor por defecto opcional
  });
}
