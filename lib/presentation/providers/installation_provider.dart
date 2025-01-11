import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/installation_repository.dart';

// Proveedor del repositorio
final installationRepositoryProvider = Provider<InstallationRepository>((ref) {
  return InstallationRepository();
});

// Proveedor de lista de instalaciones (lectura en tiempo real)
final installationListProvider = StreamProvider<List<InstallationModel>>((ref) {
  final installationRepository = ref.watch(installationRepositoryProvider);
  return installationRepository.getInstallations();
});

// Proveedor para una instalación específica (lectura única)
final installationProvider = FutureProvider.family<InstallationModel, String>((ref, id) {
  final installationRepository = ref.watch(installationRepositoryProvider);
  return installationRepository.getInstallation(id);
});

// Proveedor para manejar acciones (como eliminar una instalación)
final installationActionsProvider = Provider<InstallationActions>((ref) {
  final installationRepository = ref.watch(installationRepositoryProvider);
  return InstallationActions(installationRepository);
});

// Clase para manejar acciones sobre las instalaciones
class InstallationActions {
  final InstallationRepository _repository;

  InstallationActions(this._repository);

  Future<void> deleteInstallation(String id) async {
    await _repository.deleteInstallation(id);
  }
}