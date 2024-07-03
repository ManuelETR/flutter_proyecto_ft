import 'package:flutter_proyecto_ft/domain/entities/client.dart';

class Order{
  final int id;
  final Client client;
  final String frendlyId;   
  final DateTime date;
  String? invoiceNumber;

  Order({
    required this.id, 
    required this.frendlyId, 
    required this.date,
    required this.client,
    this.invoiceNumber
    });


}