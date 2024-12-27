import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';

abstract class MaintenanceRepository {
  Future<void> createMaintenance(MaintenanceModel maintenance);
  Future<List<MaintenanceModel>> getMaintenances();
  Future<void> updateMaintenance(MaintenanceModel maintenance);
  Future<void> deleteMaintenance(int id);
}