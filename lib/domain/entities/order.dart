import 'package:flutter_proyecto_ft/domain/entities/client.dart';

class OrderC {
  final int id;
  final Client client;
  String? friendlyId;
  final DateTime date;
  String? invoiceNumber;

  OrderC({
    required this.id,
    required this.friendlyId,
    required this.date,
    required this.client,
    this.invoiceNumber, required String frendlyId,
  });
}