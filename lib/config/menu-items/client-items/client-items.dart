import 'package:flutter/material.dart';

class ClientMenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const ClientMenuItem({
    required this.title,
    this.subTitle = '',
    required this.link,
    required this.icon,
  });
}

// Opciones del menú "Clientes y Trabajos"
const clientMenuItems = <ClientMenuItem>[
  ClientMenuItem(
    title: 'Trabajos Pendientes',
    subTitle: 'Visualiza los trabajos que aún no se han completado.',
    link: '/clients-pending',
    icon: Icons.pending_actions_sharp,
  ),
  ClientMenuItem(
    title: 'Historial',
    subTitle: 'Revisa el historial de trabajos realizados.',
    link: '/clients-history',
    icon: Icons.history_edu_sharp,
  ),
];
