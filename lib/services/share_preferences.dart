import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyCorrectAnswers = 'correct_answers';
  static const String _keyIncorrectAnswers = 'incorrect_answers';

  /// Guarda los resultados de respuestas correctas e incorrectas.
  static Future<void> saveResults({
    required int correctAnswers,
    required int incorrectAnswers,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCorrectAnswers, correctAnswers);
    await prefs.setInt(_keyIncorrectAnswers, incorrectAnswers);
  }

  /// Obtiene los resultados guardados como un mapa.
  static Future<Map<String, int>> getResults() async {
    final prefs = await SharedPreferences.getInstance();
    final correctAnswers = prefs.getInt(_keyCorrectAnswers) ?? 0;
    final incorrectAnswers = prefs.getInt(_keyIncorrectAnswers) ?? 0;
    return {
      'correct_answers': correctAnswers,
      'incorrect_answers': incorrectAnswers,
    };
  }

  /// Borra los resultados almacenados en las preferencias.
  static Future<void> clearResults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCorrectAnswers);
    await prefs.remove(_keyIncorrectAnswers);
  }

  /// Actualiza una clave específica con un nuevo valor.
  static Future<void> updateKey(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  /// Verifica si los resultados están disponibles.
  static Future<bool> hasResults() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyCorrectAnswers) ||
        prefs.containsKey(_keyIncorrectAnswers);
  }
}
