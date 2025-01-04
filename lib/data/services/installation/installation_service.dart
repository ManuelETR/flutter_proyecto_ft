import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';

class InstallationService {
  final CollectionReference _installationsCollection = FirebaseFirestore.instance.collection('installations');

  Future<void> addInstallation(InstallationModel installation) async {
    await _installationsCollection.add(installation.toMap());
  }

  Future<void> updateInstallation(String id, InstallationModel installation) async {
    await _installationsCollection.doc(id).update(installation.toMap());
  }

  Future<void> deleteInstallation(String id) async {
    await _installationsCollection.doc(id).delete();
  }

  Future<InstallationModel> getInstallation(String id) async {
    DocumentSnapshot doc = await _installationsCollection.doc(id).get();
    return InstallationModel.fromFirestore(doc);
  }

  Stream<List<InstallationModel>> getInstallations() {
    return _installationsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => InstallationModel.fromFirestore(doc)).toList();
    });
  }
}