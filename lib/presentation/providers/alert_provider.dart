import 'package:flutter_proyecto_ft/data/services/alert/alert_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/data/models/alert_model.dart';

final alertServiceProvider = Provider<AlertService>((ref) {
  return AlertService();
});

final alertListProvider = StreamProvider<List<AlertModel>>((ref) {
  final alertService = ref.watch(alertServiceProvider);
  return alertService.getAlerts();
});
