import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/menu-items/menu-items.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/logout/logout_dialog.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int? navDrawerIndex;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) async {
        setState(() {
          navDrawerIndex = value;
        });

        // Lista combinada de opciones principales y secundarias
        final allMenuItems = [...appMenuItemsMain, ...appMenuItemsSecondary];
        final selectedItem = allMenuItems[value];

        // Si es 'Cerrar sesión', mostramos el diálogo de logout
        if (selectedItem.key == 'logout') {
          final logoutDialog = LogoutDialog(context);
          await logoutDialog.show();
        } else if (selectedItem.link.isNotEmpty) {
          // Cerrar el drawer antes de hacer la navegación
          Navigator.pop(context);

          // Realizamos la navegación a la sección deseada
          context.push(selectedItem.link);
        }
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
        ),
        // Opciones principales
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Opciones principales',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...appMenuItemsMain.map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )),

        const Divider(), // Separador entre principales y secundarias

        // Opciones secundarias
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Opciones secundarias',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...appMenuItemsSecondary.map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )),
      ],
    );
  }
}