import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/alert_model.dart';

class AlertRepository {
  final CollectionReference _alertsCollection =
      FirebaseFirestore.instance.collection('alerts');

  Future<void> addAlert(AlertModel alert) async {
    await _alertsCollection.add(alert.toMap());
  }

  Future<void> updateAlert(String id, AlertModel alert) async {
    await _alertsCollection.doc(id).update(alert.toMap());
  }

  Future<void> deleteAlert(String id) async {
    await _alertsCollection.doc(id).delete();
  }

  Future<AlertModel> getAlert(String id) async {
    final doc = await _alertsCollection.doc(id).get();
    return AlertModel.fromFirestore(doc);
  }

  Stream<List<AlertModel>> getAlerts() {
    return _alertsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AlertModel.fromFirestore(doc)).toList();
    });
  }
}
