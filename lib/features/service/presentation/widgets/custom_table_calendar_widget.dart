import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendarWidget extends StatefulWidget {
  const CustomTableCalendarWidget({super.key});

  @override
  State<CustomTableCalendarWidget> createState() =>
      _CustomTableCalendarWidgetState();
}

class _CustomTableCalendarWidgetState extends State<CustomTableCalendarWidget> {
  DateTime? _focusedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final List<DateTime> availableDays = List.generate(30, (index) {
      final date = today.add(Duration(days: index));
      return date;
    });

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return TableCalendar(
            daysOfWeekHeight: 36,
            headerStyle: HeaderStyle(
              headerMargin: const EdgeInsets.only(bottom: 8),
              leftChevronPadding: const EdgeInsets.symmetric(vertical: 8),
              rightChevronPadding: const EdgeInsets.symmetric(vertical: 8),
              headerPadding: EdgeInsets.symmetric(horizontal: 48),
              titleTextStyle: const TextStyle(color: Colors.black),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.black),
              titleCentered: true,
            ),
            locale: 'es_EC',
            availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                final month = _monthNameInSpanish(day.month).toUpperCase();
                return Text(
                  '$month ${day.year}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              },
              dowBuilder: (context, day) {
                final text =
                    ['D', 'L', 'M', 'MI', 'J', 'V', 'S'][day.weekday % 7];
                return Container(
                    alignment: Alignment.center,
                    color: Color(0xFFE596A9),
                    child: Text(text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)));
              },
              defaultBuilder: (context, day, focusedDay) {
                final isAvailable = availableDays.any((availableDay) =>
                    availableDay.year == day.year &&
                    availableDay.month == day.month &&
                    availableDay.day == day.day);

                final isSelected = isSameDay(state.dateSelected, day);

                if (isSelected) return null;

                return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: isAvailable
                            ? Colors.transparent
                            : const Color(0xFFF44565),
                        shape: BoxShape.circle),
                    child: Center(
                        child: Text(day.day.toString(),
                            style: TextStyle(
                                color: isAvailable
                                    ? Colors.black
                                    : Colors.white))));
              },
            ),
            focusedDay: _focusedDay ?? DateTime.now(),
            firstDay: DateTime.utc(2023),
            lastDay: DateTime.utc(2099),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(state.dateSelected, selectedDay) &&
                  availableDays.any((availableDay) =>
                      availableDay.year == selectedDay.year &&
                      availableDay.month == selectedDay.month &&
                      availableDay.day == selectedDay.day)) {
                context
                    .read<ServicesSelectedBloc>()
                    .add(SelectDateTimeEvent(dateSelected: selectedDay));
                _focusedDay = focusedDay;
              }
            },
            selectedDayPredicate: (day) => isSameDay(state.dateSelected, day),
            calendarFormat: CalendarFormat.month,
            calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                todayDecoration: BoxDecoration(
                    color: Color(0XFFF3B4C7), shape: BoxShape.circle),
                outsideDaysVisible: false,
                selectedDecoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            });
      }
      return const SizedBox.shrink();
    });
  }
}

String _monthNameInSpanish(int month) {
  const months = [
    'ENERO',
    'FEBRERO',
    'MARZO',
    'ABRIL',
    'MAYO',
    'JUNIO',
    'JULIO',
    'AGOSTO',
    'SEPTIEMBRE',
    'OCTUBRE',
    'NOVIEMBRE',
    'DICIEMBRE'
  ];
  return months[month - 1];
}
