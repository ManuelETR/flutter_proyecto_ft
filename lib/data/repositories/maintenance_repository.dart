import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/services/maintenance/maintenance_service.dart';

class MaintenanceRepository {
  final MaintenanceService _maintenanceService = MaintenanceService();

  Future<void> addMaintenance(MaintenanceModel maintenance) async {
    await _maintenanceService.addMaintenance(maintenance);
  }

  Future<void> updateMaintenance(String id, MaintenanceModel maintenance) async {
    await _maintenanceService.updateMaintenance(id, maintenance);
  }

  Future<void> deleteMaintenance(String id) async {
    await _maintenanceService.deleteMaintenance(id);
  }

  Future<MaintenanceModel> getMaintenance(String id) async {
    return await _maintenanceService.getMaintenance(id);
  }

  Stream<List<MaintenanceModel>> getMaintenances() {
    return _maintenanceService.getMaintenances();
  }
}