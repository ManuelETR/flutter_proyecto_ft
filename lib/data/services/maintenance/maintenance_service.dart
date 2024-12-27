import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/repositories/maintenance_repository.dart';

class FirestoreMaintenanceService implements MaintenanceRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createMaintenance(MaintenanceModel maintenance) async {
    // Crear una nueva orden
    var orderRef = firestore.collection('orders').doc();
    var order = OrderModel.fromOrderC(maintenance.order);
    await orderRef.set(order.toMap());

    // Crear un nuevo mantenimiento
    var maintenanceRef = firestore.collection('maintenances').doc();
    var maintenanceModel = MaintenanceModel(
      id: maintenanceRef.id.hashCode, // Usar hashCode para generar un ID único
      order: order,
      scheduleDate: maintenance.scheduleDate,
      completionDate: maintenance.completionDate,
      notes: maintenance.notes,
    );
    await maintenanceRef.set(maintenanceModel.toMap());
  }

  @override
  Future<List<MaintenanceModel>> getMaintenances() async {
    var querySnapshot = await firestore.collection('maintenances').get();
    return querySnapshot.docs
        .map((doc) => MaintenanceModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> updateMaintenance(MaintenanceModel maintenance) async {
    var maintenanceRef = firestore.collection('maintenances').doc(maintenance.id.toString());
    await maintenanceRef.update(maintenance.toMap());
  }

  @override
  Future<void> deleteMaintenance(int id) async {
    var maintenanceRef = firestore.collection('maintenances').doc(id.toString());
    await maintenanceRef.delete();
  }
}