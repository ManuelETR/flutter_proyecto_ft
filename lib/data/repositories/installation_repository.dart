import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/services/installation/installation_service.dart';

class InstallationRepository {
  final InstallationService _installationService = InstallationService();

  Future<void> addInstallation(InstallationModel installation) async {
    await _installationService.addInstallation(installation);
  }

  Future<void> updateInstallation(String id, InstallationModel installation) async {
    await _installationService.updateInstallation(id, installation);
  }

  Future<void> deleteInstallation(String id) async {
    await _installationService.deleteInstallation(id);
  }

  Future<InstallationModel> getInstallation(String id) async {
    return await _installationService.getInstallation(id);
  }

  Stream<List<InstallationModel>> getInstallations() {
    return _installationService.getInstallations();
  }
}