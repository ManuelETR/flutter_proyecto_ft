// domain/use_cases/create_installation.dart
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/domain/repositories/installation_repository.dart';

class CreateInstallation {
  final InstallationRepository repository;

  CreateInstallation(this.repository);

  Future<void> execute(Installation installation) async {
    await repository.createInstallation(installation);
  }
}
