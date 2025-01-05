// import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
// import 'package:flutter_proyecto_ft/data/services/installation/installation_service.dart';
// import 'package:flutter_proyecto_ft/domain/repositories/installation_repository.dart';

// class FirestoreInstallationRepository implements InstallationRepository {
//   final InstallationService _installationService = InstallationService();

//   @override
//   Future<void> addInstallation(InstallationModel installation) async {
//     await _installationService.addInstallation(installation);
//   }

//   @override
//   Future<void> updateInstallation(String id, InstallationModel installation) async {
//     await _installationService.updateInstallation(id, installation);
//   }

//   @override
//   Future<void> deleteInstallation(String id) async {
//     await _installationService.deleteInstallation(id);
//   }

//   @override
//   Future<InstallationModel> getInstallation(String id) async {
//     return await _installationService.getInstallation(id);
//   }

//   @override
//   Stream<List<InstallationModel>> getInstallations() {
//     return _installationService.getInstallations();
//   }
// }