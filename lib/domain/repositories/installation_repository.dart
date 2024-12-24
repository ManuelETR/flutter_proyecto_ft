// domain/repositories/installation_repository.dart
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';

abstract class InstallationRepository {
  Future<void> createInstallation(Installation installation);
  Future<List<Installation>> getInstallations();
  Future<void> updateInstallation(Installation installation);
  Future<void> deleteInstallation(int id);
}
