import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';

class ClientService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear un nuevo cliente
  Future<void> addClient(ClientModel client) async {
    try {
      await _db.collection('clients').doc(client.id.toString()).set(client.toMap());
    } catch (e) {
      print("Error adding client: $e");
    }
  }

  // Obtener un cliente por ID
  Future<ClientModel?> getClient(int id) async {
    try {
      DocumentSnapshot snapshot = await _db.collection('clients').doc(id.toString()).get();
      if (snapshot.exists) {
        return ClientModel.fromFirestore(snapshot);
      }
    } catch (e) {
      print("Error fetching client: $e");
    }
    return null;
  }

  // Obtener todos los clientes
  Future<List<ClientModel>> getAllClients() async {
    try {
      QuerySnapshot snapshot = await _db.collection('clients').get();
      return snapshot.docs.map((doc) => ClientModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching all clients: $e");
      return [];
    }
  }

  // Eliminar un cliente por ID
  Future<void> deleteClient(int clientId) async {
    try {
      await _db.collection('clients').doc(clientId.toString()).delete();
    } catch (e) {
      print("Error deleting client: $e");
    }
  }
}