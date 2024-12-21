import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog {
  final BuildContext context;

  LogoutDialog(this.context);

  Future<void> show() async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancelar
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirmar
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      final authService = AuthService();
      await authService.signOut();
      // Redirigir al usuario a la pantalla de login
      if (context.mounted) {
        context.goNamed('login_screen'); // Reemplazar por la lógica deseada
      }
    }
  }
}
