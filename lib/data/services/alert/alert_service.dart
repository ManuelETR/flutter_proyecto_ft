import 'package:flutter_proyecto_ft/data/models/alert_model.dart';
import 'package:flutter_proyecto_ft/data/repositories/alert_repository.dart';

class AlertService {
  final AlertRepository _alertRepository = AlertRepository();

  Future<void> createAlert(String orderId, DateTime alertDate, String message) async {
    final alert = AlertModel(
      id: '', // El ID será asignado automáticamente por Firestore
      orderId: orderId,
      alertDate: alertDate,
      message: message,
    );

    await _alertRepository.addAlert(alert);
  }

  Stream<List<AlertModel>> getAlerts() {
    return _alertRepository.getAlerts();
  }

  Future<void> deleteAlert(String id) async {
    await _alertRepository.deleteAlert(id);
  }
}
