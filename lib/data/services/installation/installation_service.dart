// data/services/firestore_installation_service.dart
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/domain/repositories/installation_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstallationService implements InstallationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createInstallation(Installation installation) async {
    var installationRef = firestore.collection('installations').doc();
    await installationRef.set((installation as InstallationModel).toMap());
  }

  @override
  Future<List<Installation>> getInstallations() async {
    var querySnapshot = await firestore.collection('installations').get();
    return querySnapshot.docs
        .map((doc) => InstallationModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> updateInstallation(Installation installation) async {
    var installationRef = firestore.collection('installations').doc(installation.id.toString());
    await installationRef.update((installation as InstallationModel).toMap());
  }

  @override
  Future<void> deleteInstallation(int id) async {
    var installationRef = firestore.collection('installations').doc(id.toString());
    await installationRef.delete();
  }
}
