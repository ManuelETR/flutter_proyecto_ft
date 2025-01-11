import 'package:flutter_proyecto_ft/domain/entities/client.dart';
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/domain/entities/maintenance.dart';

class OrderC {
  final String id;
  final Client client;
  final String friendlyId;
  final DateTime date;
  final String? invoiceNumber;
  final Installation? installation;
  final Maintenance? maintenance;
  final String type; // "installation" o "maintenance"

  OrderC({
    required this.id,
    required this.client,
    required this.friendlyId,
    required this.date,
    this.invoiceNumber,
    this.installation,
    this.maintenance,
    required this.type,
  });
}