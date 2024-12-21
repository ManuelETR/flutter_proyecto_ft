//Estado => isDarkmodeProvider = boolean
import 'package:flutter_proyecto_ft/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Provider para el tema oscuro
final isDarkmodeProvider = StateProvider<bool>((ref) => false);

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

//Color seleccionado
final selectedColorProvider = StateProvider<int>((ref) => 0);