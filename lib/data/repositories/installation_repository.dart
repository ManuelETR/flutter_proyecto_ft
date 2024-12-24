import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';

class InstalacionRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('instalaciones');

  // Método para agregar una instalación
  Future<void> addInstalacion(Installation instalacion) async {
    // Convertir la entidad a su modelo para Firestore (usamos InstallationModel)
    final installationModel = instalacion as InstallationModel;  // Asegúrate de usar el tipo adecuado
    await _collection.add(installationModel.toMap());
  }

  // Método para obtener todas las instalaciones
  Future<List<Installation>> fetchInstalaciones() async {
    final snapshot = await _collection.get();
    // Convertir cada documento a un modelo de instalación
    return snapshot.docs
        .map((doc) => InstallationModel.fromFirestore(doc))
        .toList();
  }
}
