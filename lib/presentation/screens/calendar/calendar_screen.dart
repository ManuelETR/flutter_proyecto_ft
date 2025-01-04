import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_proyecto_ft/presentation/providers/order_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const String name = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderListProvider);

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
                  return orders.when(
                    data: (orders) {
                      final dayOrders = orders.where((order) => isSameDay(order.date, date)).toList();
                      if (dayOrders.isNotEmpty) {
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
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => const Icon(Icons.error),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            flex: 1,
            child: orders.when(
              data: (orders) {
                final dayOrders = orders.where((order) => isSameDay(order.date, _selectedDay)).toList();
                if (dayOrders.isEmpty) {
                  return const Center(child: Text('No hay órdenes para este día.'));
                }
                return ListView.builder(
                  itemCount: dayOrders.length,
                  itemBuilder: (context, index) {
                    final order = dayOrders[index];
                    return ListTile(
                      title: Text('Orden ${order.friendlyId}'),
                      subtitle: Text('Cliente: ${order.client.names} ${order.client.lastNames}'),
                      onTap: () {
                        // Navegar a la pantalla de detalles de la orden
                      },
                    );
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}