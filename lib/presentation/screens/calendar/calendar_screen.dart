import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import '../../providers/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const String name = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<calendar.Event>> _events = {};

  @override
  Widget build(BuildContext context) {
    final eventsAsyncValue = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 220, 219),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: TableCalendar(
              locale: 'es_ES', // Configurar el calendario en español
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
                defaultTextStyle: TextStyle(color: Colors.black),
                weekendTextStyle: TextStyle(color: Colors.black),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
                weekdayStyle: TextStyle(color: Colors.black),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final dayEvents = _events[date] ?? [];
                  if (dayEvents.isNotEmpty) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            flex: 1,
            child: eventsAsyncValue.when(
              data: (events) {
                print('Eventos obtenidos: $events');
                _events = {};
                for (var event in events) {
                  final eventDate = event.start?.dateTime ?? event.start?.date;
                  if (eventDate != null) {
                    final date = DateTime(eventDate.year, eventDate.month, eventDate.day);
                    if (_events[date] == null) {
                      _events[date] = [];
                    }
                    _events[date]!.add(event);
                  }
                }

                final dayEvents = _events[_selectedDay] ?? [];
                if (dayEvents.isEmpty) {
                  return const Center(child: Text('No hay eventos para este día.'));
                }
                return ListView.builder(
                  itemCount: dayEvents.length,
                  itemBuilder: (context, index) {
                    final event = dayEvents[index];
                    return ListTile(
                      title: Text(event.summary ?? 'Sin título'),
                      subtitle: Text(event.start?.dateTime?.toString() ?? 'Sin fecha'),
                      onTap: () {
                        // Navegar a la pantalla de detalles del evento
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                print('Error al cargar los eventos: $err');
                return const Center(child: Text('Error al cargar los eventos'));
              },
            ),
          ),
        ],
      ),
    );
  }
}