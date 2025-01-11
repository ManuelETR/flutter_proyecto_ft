import 'package:flutter_proyecto_ft/domain/entities/address.dart';

class Client {
  final int id;
  late String names;
  late String lastNames;
  String? tel;
  late Address address; // Uso de la entidad Address
  List<String> orderIds;

  Client({
    required this.id,
    required this.names,
    required this.lastNames,
    required this.address,
    this.tel,
    this.orderIds = const [],
  });
}
