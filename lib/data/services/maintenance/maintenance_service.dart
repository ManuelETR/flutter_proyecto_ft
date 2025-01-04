import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';

class MaintenanceService {
  final CollectionReference _maintenancesCollection = FirebaseFirestore.instance.collection('maintenances');

  Future<void> addMaintenance(MaintenanceModel maintenance) async {
    await _maintenancesCollection.add(maintenance.toMap());
  }

  Future<void> updateMaintenance(String id, MaintenanceModel maintenance) async {
    await _maintenancesCollection.doc(id).update(maintenance.toMap());
  }

  Future<void> deleteMaintenance(String id) async {
    await _maintenancesCollection.doc(id).delete();
  }

  Future<MaintenanceModel> getMaintenance(String id) async {
    DocumentSnapshot doc = await _maintenancesCollection.doc(id).get();
    return MaintenanceModel.fromFirestore(doc);
  }

  Stream<List<MaintenanceModel>> getMaintenances() {
    return _maintenancesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MaintenanceModel.fromFirestore(doc)).toList();
    });
  }
}