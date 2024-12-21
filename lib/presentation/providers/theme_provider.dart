//Estado => isDarkmodeProvider = boolean
import 'package:flutter_proyecto_ft/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Provider para el tema oscuro
final isDarkmodeProvider = StateProvider<bool>((ref) => false);

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

//Color seleccionado
final selectedColorProvider = StateProvider<int>((ref) => 0);

//Un objeto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
    (ref) => ThemeNotifier(),
  );

//Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  
  //STATE = Estado = new AppTheme(); - nueva instancia.
  ThemeNotifier(): super(AppTheme());
  

  void toggleDarkmode(){
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }

  void changeColorIndex(int newIndex){
    state = state.copyWith(selectedColor: newIndex);
  }

}