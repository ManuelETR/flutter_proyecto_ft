import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import '../../data/services/calendar/calendar_service.dart';

final calendarServiceProvider = Provider<CalendarService>((ref) {
  return CalendarService();
});

final eventsProvider = FutureProvider<List<calendar.Event>>((ref) async {
  final calendarService = ref.watch(calendarServiceProvider);
  return await calendarService.getEvents();
});