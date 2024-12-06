import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/menu-items/menu-items.dart';
import 'package:flutter_proyecto_ft/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {

  static const String name = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
        title: const Center(
            child: Text('Multiservicios Toledo',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 32,
                    color: Color(0xFFb40506),
                    fontWeight: FontWeight.bold,
                    ))),
      ),
      body: const _HomeView(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _showLogoutDialog(context);
      },
      tooltip: 'Cerrar Sesión',
        backgroundColor: colors.primary,
        foregroundColor: Colors.white, // Color del icono
        child: const Icon(Icons.logout),
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true); // Cerrar el diálogo y confirmar la acción

                // Cerrar sesión con Firebase Auth
                await FirebaseAuth.instance.signOut();

                // Cerrar sesión con Google si el usuario inició sesión con Google
                final GoogleSignIn googleSignIn = GoogleSignIn();
                if (await googleSignIn.isSignedIn()) {
                  await googleSignIn.signOut();
                }

                // Redirigir a la pantalla de inicio de sesión
                // ignore: use_build_context_synchronously
                context.goNamed(LoginPage.name);
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );

  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    //ListTile
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];

        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary, size: 30,),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title, style: TextStyle(fontWeight: FontWeight.bold, color: colors.secondary),),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push( menuItem.link);
      },
    );
  }
}
