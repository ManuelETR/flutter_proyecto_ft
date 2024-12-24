import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstallationModel extends Installation {
  InstallationModel({
    required int id,
    required OrderModel order,  // Aquí usas 'OrderModel' porque estás trabajando con el modelo
    required ProductModel product,
    DateTime? scheduleDate,
    DateTime? completionDate,
    String? notes,
    StatusType status = StatusType.pending,
  }) : super(
          id: id,
          order: order.toOrderC(),  // Convierte 'order' a 'OrderC'
          product: product,
          scheduleDate: scheduleDate,
          completionDate: completionDate,
          notes: notes,
          status: status,  // Pasa el parámetro 'status'
        );

  // Convertir de Firestore a un objeto InstallationModel
  factory InstallationModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return InstallationModel(
      id: data['id'],
      order: OrderModel.fromFirestore(data['order']),  // Convierte 'order' correctamente
      product: ProductModel.fromFirestore(data['product']),
      scheduleDate: (data['scheduleDate'] as Timestamp).toDate(),
      completionDate: (data['completionDate'] as Timestamp).toDate(),
      notes: data['notes'],
      status: StatusType.values[data['status']],
    );
  }

  // Convertir un objeto InstallationModel a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': (order as OrderModel).toMap(),  // Convierte 'order' correctamente
      'product': (product as ProductModel).toMap(),
      'scheduleDate': scheduleDate,
      'completionDate': completionDate,
      'notes': notes,
      'status': status.index,  // Convierte 'status' correctamente
    };
  }
}
