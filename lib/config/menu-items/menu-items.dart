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
    title: 'Ver Clientes',
    subTitle: 'Mostrar la lista de clientes registrados y permitir ver o agregar nuevos clientes.',
    link: '/clients',
    icon: Icons.assignment_ind_sharp,
  ),
  MenuItem(
    title: 'Registrar Producto',
    subTitle: 'Registrar un nuevo producto o ver detalles de un producto existente.',
    link: '/products',
    icon: Icons.app_registration_rounded,
  ),
  MenuItem(
    title: 'Ver Mantenimientos',
    subTitle: 'Mostrar mantenimientos programados y gestionar notificaciones.',
    link: '/maintenance',
    icon: Icons.assignment,
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
