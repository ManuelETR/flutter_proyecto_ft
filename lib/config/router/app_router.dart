import 'package:flutter_proyecto_ft/presentation/screens/mission_screen/mission_screen.dart';
import 'package:flutter_proyecto_ft/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: LoginPage.name,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/sign',
      name: SignUpPage.name,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/clients',
      name: ClientScreen.name,
      builder: (context, state) => const ClientScreen(),
    ),

    GoRoute(
      path: '/products',
      name: ProductsScreen.name,
      builder: (context, state) => const ProductsScreen(),
    ),

    GoRoute(
      path: '/maintenance',
      name: MaintenanceScreen.name,
      builder: (context, state) => const MaintenanceScreen(),
    ),

    GoRoute(
      path: '/configuration',
      name: ConfigurationScreen.name,
      builder: (context, state) => const ConfigurationScreen(),
    ),

    GoRoute(
      path: '/mission',
      name: MissionScreen.name,
      builder: (context, state) => const MissionScreen(),
    ),
  ]
);