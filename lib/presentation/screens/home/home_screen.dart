import 'package:flutter/material.dart';
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
      body: const _AlertsView(), // Aquí va la lista de alertas
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _AlertsView extends StatelessWidget {
  const _AlertsView();

  @override
  Widget build(BuildContext context) {
    // Aquí puedes implementar la lógica de las alertas
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, size: 50, color: Colors.orange),
          SizedBox(height: 10),
          Text(
            "Aquí aparecerán las alertas de trabajos próximos.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
