import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/menu-items/menu-items.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/generales/side_menu.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
        title: const Text(
          'Multiservicios Toledo',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 29,
            color: Color(0xFFb40506),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const _HomeView(),
      endDrawer: SideMenu( scaffoldKey: scaffoldKey), // Aquí integraremos el SideMenu
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItemsMain.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItemsMain[index];

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
