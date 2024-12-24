import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;
  final String key;

  const MenuItem({
    required this.title,
    this.subTitle = '',
    required this.link,
    required this.icon,
    this.key = '', // El key puede usarse para identificar elementos como 'logout'
  });
}

// Opciones principales
const appMenuItemsMain = <MenuItem>[
    MenuItem(
    title: 'Registrar',
    subTitle: 'Registro de Instalación o Registro de Mantenimiento.',
    link: '/register',
    icon: Icons.app_registration_sharp,
  ),
  MenuItem(
    title: 'Clientes y Trabajos',
    subTitle: 'Trabajos Pendientes e Historial',
    link: '/clients',
    icon: Icons.assignment_ind_sharp,
  ),
  MenuItem(
    title: 'Calendario de Trabajo',
    subTitle: 'Citas futuras y Estado de cada trabajo',
    link: '/calendar',
    icon: Icons.edit_calendar_rounded,
  ),
];

// Opciones secundarias
const appMenuItemsSecondary = <MenuItem>[
  MenuItem(
    title: 'Configuración',
    link: '/configuration',
    icon: Icons.tune_sharp,
  ),
  MenuItem(
    title: 'Misión, Visión y Valores',
    link: '/mission',
    icon: Icons.token_outlined,
  ),
    MenuItem(
    title: 'Temas de la aplicación',
    link: '/themes',
    icon: Icons.color_lens_outlined,
  ),
  MenuItem(
    title: 'Cerrar Sesión',
    link: '',  // No tiene link ya que manejamos logout por separado
    icon: Icons.exit_to_app,
    key: 'logout', // Lo identificamos por un key
  ),
];
