import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/data/services/clients/clients_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientListProvider = StateNotifierProvider<ClientListNotifier, AsyncValue<List<ClientModel>>>((ref) {
  return ClientListNotifier();
});

class ClientListNotifier extends StateNotifier<AsyncValue<List<ClientModel>>> {
  final ClientService _clientService = ClientService();

  ClientListNotifier() : super(const AsyncValue.loading()) {
    _loadClients();
  }

  Future<void> _loadClients() async {
    try {
      // Cambia el estado a `loading`
      state = const AsyncValue.loading();

      // Carga los clientes desde el servicio
      List<ClientModel> clients = await _clientService.getAllClients();

      // Cambia el estado a `data` con los clientes cargados
      state = AsyncValue.data(clients);
    } catch (e, stack) {
      // Cambia el estado a `error` si ocurre un problema
      state = AsyncValue.error(e, stack);
      print("Error loading clients: $e");
    }
  }

  Future<void> addClient(ClientModel client) async {
    try {
      await _clientService.addClient(client);

      // Si el estado actual es `data`, agrega el cliente al estado existente
      state.whenData((clients) {
        state = AsyncValue.data([...clients, client]);
      });
    } catch (e, stack) {
      print("Error adding client: $e");
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> removeClient(int clientId) async {
    try {
      await _clientService.deleteClient(clientId);

      // Si el estado actual es `data`, elimina el cliente del estado
      state.whenData((clients) {
        state = AsyncValue.data(clients.where((client) => client.id != clientId).toList());
      });
    } catch (e, stack) {
      print("Error removing client: $e");
      state = AsyncValue.error(e, stack);
    }
  }
}