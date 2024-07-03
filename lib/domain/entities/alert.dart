import 'package:flutter_proyecto_ft/domain/entities/installation.dart';

class Alert{
  final int id;
  final Installation installation;
  bool isIgnored = false;
  DateTime? snoozeDate;

  Alert({
  required this.id, 
  required this.installation, 
  });
}