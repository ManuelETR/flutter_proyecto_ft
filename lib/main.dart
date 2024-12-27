import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/config/router/app_router.dart';
import 'package:flutter_proyecto_ft/config/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_proyecto_ft/firebase_options.dart';
import 'package:flutter_proyecto_ft/presentation/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Asegura que Flutter esté completamente inicializado
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  // Inicializa Firebase
    if (kDebugMode) {
      print("Firebase inicializado correctamente");
    }  // Mensaje de confirmación
  } catch (e) {
    if (kDebugMode) {
      print("Error al inicializar Firebase: $e");
    }
  }

  runApp(
    const ProviderScope(
      child:  MainApp())
    );  // Ejecuta la aplicación
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
        title: 'Multiservicios Toledo',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: appTheme.getTheme(),
        
      );
  }
}
