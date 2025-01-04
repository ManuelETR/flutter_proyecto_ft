import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/installation_repository.dart';

final installationRepositoryProvider = Provider<InstallationRepository>((ref) {
  return InstallationRepository();
});

final installationListProvider = StreamProvider<List<InstallationModel>>((ref) {
  final installationRepository = ref.watch(installationRepositoryProvider);
  return installationRepository.getInstallations();
});

final installationProvider = FutureProvider.family<InstallationModel, String>((ref, id) {
  final installationRepository = ref.watch(installationRepositoryProvider);
  return installationRepository.getInstallation(id);
});