import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/router/app_router.dart';
import 'package:flutter_proyecto_ft/config/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_proyecto_ft/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Asegura que Flutter esté completamente inicializado
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  // Inicializa Firebase
    print("Firebase inicializado correctamente");  // Mensaje de confirmación
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }
  runApp(const MainApp());  // Ejecuta la aplicación
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 0).getTheme(),
        
      );
  }
}
