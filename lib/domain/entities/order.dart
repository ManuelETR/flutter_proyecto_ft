import 'package:flutter_proyecto_ft/domain/entities/client.dart';

class OrderC {
  final int id;
  final Client client;
  final String frendlyId;
  final DateTime date;
  String? invoiceNumber;

  OrderC({
    required this.id,
    required this.frendlyId,
    required this.date,
    required this.client,
    this.invoiceNumber,
  });
}