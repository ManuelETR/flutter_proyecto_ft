import 'package:flutter_proyecto_ft/domain/entities/maintenance.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenanceModel extends Maintenance {
  MaintenanceModel({
    required super.id,
    required OrderModel order,  // Aquí usas 'OrderModel' porque estás trabajando con el modelo
    super.scheduleDate,
    super.completionDate,
    super.notes,
  }) : super(
          order: order.toOrderC(),
        );

  // Convertir de Firestore a un objeto MaintenanceModel
  factory MaintenanceModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return MaintenanceModel(
      id: data['id'],
      order: OrderModel.fromFirestore(data['order']),  // Convierte 'order' correctamente
      scheduleDate: (data['scheduleDate'] as Timestamp).toDate(),
      completionDate: (data['completionDate'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }

  // Convertir un objeto MaintenanceModel a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': (order as OrderModel).toMap(),  // Convierte 'order' correctamente
      'scheduleDate': scheduleDate,
      'completionDate': completionDate,
      'notes': notes,
    };
  }
}