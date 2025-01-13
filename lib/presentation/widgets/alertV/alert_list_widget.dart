import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/alert_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertListProvider);

    return alerts.when(
      data: (alerts) {
        if (alerts.isEmpty) {
          return const Text('No hay alertas pendientes.');
        }

        return ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return ListTile(
              title: Text(alert.message),
              subtitle: Text('Fecha: ${alert.alertDate.toLocal()}'),
              trailing: Icon(Icons.notifications_active),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
