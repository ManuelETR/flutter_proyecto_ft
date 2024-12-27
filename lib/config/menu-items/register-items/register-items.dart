// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RegisterMenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const RegisterMenuItem({
    required this.title,
    this.subTitle = '',
    required this.link,
    required this.icon,
  });
}

// Opciones del menú "Registrar"
const registerMenuItems = <RegisterMenuItem>[
    RegisterMenuItem(
    title: 'Registrar Cliente',
    subTitle: 'Registrar un nuevo cliente.',
    link: '/register-client',
    icon: Icons.person_add_alt_1,
  ),
    RegisterMenuItem(
    title: 'Registrar Producto',
    subTitle: 'Registrar un nuevo producto.',
    link: '/register-product',
    icon: Icons.all_inbox_rounded,
  ),
  RegisterMenuItem(
    title: 'Registro de Instalación',
    subTitle: 'Registrar una nueva instalación de aire acondicionado.',
    link: '/register-installation',
    icon: Icons.settings_input_antenna_sharp,
  ),
  RegisterMenuItem(
    title: 'Registro de Mantenimiento',
    subTitle: 'Registrar un mantenimiento técnico.',
    link: '/register-maintenance',
    icon: Icons.build_circle_sharp,
  ),
];