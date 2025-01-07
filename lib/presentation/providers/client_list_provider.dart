import 'package:flutter/foundation.dart';
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
      state = const AsyncValue.loading(); // Cambia el estado a loading
      final List<ClientModel> clients = await _clientService.getAllClients();
      state = AsyncValue.data(clients); // Cambia el estado a data con los clientes
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // Cambia el estado a error si algo sale mal
      if (kDebugMode) {
        print("Error loading clients: $e");
      }
    }
  }

  Future<void> addClient(ClientModel client) async {
    try {
      await _clientService.addClient(client);

      // Solo actualiza el estado si está en `data`
      state.whenData((clients) {
        state = AsyncValue.data([...clients, client]);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      if (kDebugMode) {
        print("Error adding client: $e");
      }
    }
  }

  Future<void> removeClient(int clientId) async {
    try {
      await _clientService.deleteClient(clientId);

      // Solo actualiza el estado si está en `data`
      state.whenData((clients) {
        state = AsyncValue.data(clients.where((client) => client.id != clientId).toList());
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      if (kDebugMode) {
        print("Error removing client: $e");
      }
    }
  }
}
