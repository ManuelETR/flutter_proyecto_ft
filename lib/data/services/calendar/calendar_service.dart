import 'package:flutter/foundation.dart';
import 'package:flutter_proyecto_ft/data/services/auth/auth_service.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;


class CalendarService {
  final AuthService _authService = AuthService();

  Future<List<calendar.Event>> getEvents() async {
    try {
      final client = await _authService.getCalendarClient();
      final calendarApi = calendar.CalendarApi(client);
      final events = await calendarApi.events.list('primary');
      if (kDebugMode) {
        print('Eventos obtenidos: ${events.items}');
      }
      return events.items ?? [];
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener eventos: $e');
      }
      rethrow;
    }
  }

  Future<void> addEvent(calendar.Event event) async {
    try {
      final client = await _authService.getCalendarClient();
      final calendarApi = calendar.CalendarApi(client);
      await calendarApi.events.insert(event, 'primary');
    } catch (e) {
      if (kDebugMode) {
        print('Error al agregar evento: $e');
      }
      rethrow;
    }
  }
}