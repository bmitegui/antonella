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
            
            calendarBuilders: CalendarBuilders(
             
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
