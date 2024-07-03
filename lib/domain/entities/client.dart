import 'package:flutter_proyecto_ft/domain/entities/address.dart';

class Client{
  final int id;
  final String names;
  final String lastNames;
  String? tel;
  final Address address;

  Client({
    required this.id, 
    required this.names, 
    required this.lastNames, 
    required this.address,
    this.tel
    });

}