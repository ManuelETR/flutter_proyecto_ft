import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/data/models/client_model.dart';
import 'package:flutter_proyecto_ft/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
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
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/calendar',
      name: CalendarScreen.name,
      builder: (context, state) => const CalendarScreen(),
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
    GoRoute(
      path: '/themes',
      name: ThemesScreen.name,
      builder: (context, state) => const ThemesScreen(),
    ),
    GoRoute(
      path: '/register-client',
      name: 'register_client_screen',
      builder: (context, state) => const RegisterClientScreen(),
    ),
    GoRoute(
      path: '/register-installation',
      name: 'register_installation',
      builder: (context, state) => const RegisterInstallationScreen(),
    ),
    GoRoute(
      path: '/register-maintenance',
      name: 'register_maintenance',
      builder: (context, state) => const RegisterMaintenanceScreen(),
    ),
    GoRoute(
      path: '/clients-pending',
      name: 'clients_pending',
      builder: (context, state) => const ClientsPendingScreen(),
    ),
    GoRoute(
      path: '/clients-history',
      name: 'clients_history',
      builder: (context, state) => const ClientsHistoryScreen(),
    ),
    GoRoute(
      path: '/clients-detail',
      name: 'clients-detail',
      builder: (context, state) {
        final client = state.extra as ClientModel?;
        if (client == null) {
          return const Scaffold(
            body: Center(
              child: Text('Client data is missing'),
            ),
          );
        }
        return ClientDetailScreen(client: client);
      },
    ),
  ],
);