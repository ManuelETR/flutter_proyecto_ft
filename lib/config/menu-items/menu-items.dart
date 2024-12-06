import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon
    });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Ver Clientes', 
    subTitle: 'Mostrar la lista de clientes registrados y permitir ver o agregar nuevos clientes.', 
    link: '/clients', 
    icon: Icons.assignment_ind_sharp
    ),

    MenuItem(
    title: 'Registrar Producto', 
    subTitle: 'Registrar un nuevo producto o ver detalles de un producto existente.', 
    link: '/products', 
    icon: Icons.app_registration_rounded
    ),

    MenuItem(
    title: 'Ver Mantenimientos', 
    subTitle: 'Mostrar mantenimientos programados y gestionar notificaciones.', 
    link: '/maintenance', 
    icon: Icons.assignment
    ),

    MenuItem(
    title: 'Configuración', 
    subTitle: 'Personalizar opciones y preferencias.', 
    link: '/configuration', 
    icon: Icons.tune_sharp
    ),


];
