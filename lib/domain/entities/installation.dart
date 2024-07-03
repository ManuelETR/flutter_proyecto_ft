
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/entities/product.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';

class Installation{
   final int id;
   final Order order;
   final Product product;
   final StatusType status = StatusType.pending;
   DateTime? scheduleDate;
   DateTime? completionDate;
   String? notes;

  Installation({
    required this.id, 
    required this.order, 
    required this.product,
    this.scheduleDate,
    this.completionDate,
    this.notes
    });



}