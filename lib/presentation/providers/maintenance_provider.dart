import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/maintenance_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/maintenance_repository.dart';

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepository();
});

final maintenanceListProvider = StreamProvider<List<MaintenanceModel>>((ref) {
  final maintenanceRepository = ref.watch(maintenanceRepositoryProvider);
  return maintenanceRepository.getMaintenances();
});

final maintenanceProvider = FutureProvider.family<MaintenanceModel, String>((ref, id) {
  final maintenanceRepository = ref.watch(maintenanceRepositoryProvider);
  return maintenanceRepository.getMaintenance(id);
});