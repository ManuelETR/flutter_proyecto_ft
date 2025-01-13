import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/alertV/alert_list_widget.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/generales/side_menu.dart';

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
      body: AlertListWidget(), // Aquí integramos el AlertListWidget
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}
