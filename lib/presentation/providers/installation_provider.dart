import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/services/installation/installation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final installationProvider = ChangeNotifierProvider((ref) => InstallationProvider());

class InstallationProvider with ChangeNotifier {
  final FirestoreInstallationService _installationService = FirestoreInstallationService();
  List<InstallationModel> _installations = [];

  List<InstallationModel> get installations => _installations;

  Future<void> fetchInstallations() async {
    _installations = await _installationService.getInstallations();
    notifyListeners();
  }

  Future<void> addInstallation(InstallationModel installation) async {
    await _installationService.createInstallation(installation);
    _installations.add(installation);
    notifyListeners();
  }

  Future<void> updateInstallation(InstallationModel installation) async {
    await _installationService.updateInstallation(installation);
    int index = _installations.indexWhere((inst) => inst.id == installation.id);
    if (index != -1) {
      _installations[index] = installation;
      notifyListeners();
    }
  }

  Future<void> deleteInstallation(int id) async {
    await _installationService.deleteInstallation(id);
    _installations.removeWhere((inst) => inst.id == id);
    notifyListeners();
  }
}