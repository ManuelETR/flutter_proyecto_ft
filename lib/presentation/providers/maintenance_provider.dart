import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/services/maintenance/maintenance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maintenanceProvider = ChangeNotifierProvider((ref) => MaintenanceProvider());

class MaintenanceProvider with ChangeNotifier {
  final FirestoreMaintenanceService _maintenanceService = FirestoreMaintenanceService();
  List<MaintenanceModel> _maintenances = [];

  List<MaintenanceModel> get maintenances => _maintenances;

  Future<void> fetchMaintenances() async {
    _maintenances = await _maintenanceService.getMaintenances();
    notifyListeners();
  }

  Future<void> addMaintenance(MaintenanceModel maintenance) async {
    await _maintenanceService.createMaintenance(maintenance);
    _maintenances.add(maintenance);
    notifyListeners();
  }

  Future<void> updateMaintenance(MaintenanceModel maintenance) async {
    await _maintenanceService.updateMaintenance(maintenance);
    int index = _maintenances.indexWhere((mnt) => mnt.id == maintenance.id);
    if (index != -1) {
      _maintenances[index] = maintenance;
      notifyListeners();
    }
  }

  Future<void> deleteMaintenance(int id) async {
    await _maintenanceService.deleteMaintenance(id);
    _maintenances.removeWhere((mnt) => mnt.id == id);
    notifyListeners();
  }
}