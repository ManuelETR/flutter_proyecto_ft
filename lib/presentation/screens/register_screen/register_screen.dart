import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/menu-items/register-items/register-items.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = "register_screen";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registerMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = registerMenuItems[index];

        return _CustomRegisterTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomRegisterTile extends StatelessWidget {
  const _CustomRegisterTile({
    required this.menuItem,
  });

  final RegisterMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary, size: 30),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(
        menuItem.title,
        style: TextStyle(fontWeight: FontWeight.bold, color: colors.secondary),
      ),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push(menuItem.link);
      },
    );
  }
}