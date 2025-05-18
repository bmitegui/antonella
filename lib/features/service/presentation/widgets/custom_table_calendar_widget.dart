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
    final List<DateTime> availableDays = List.generate(20, (index) {
      DateTime date = DateTime.now().add(Duration(days: index));
      return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
    });

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return TableCalendar(
            headerStyle: HeaderStyle(
                headerMargin: const EdgeInsets.only(bottom: 8),
                leftChevronPadding: const EdgeInsets.symmetric(vertical: 8),
                rightChevronPadding: const EdgeInsets.symmetric(vertical: 8),
                headerPadding: EdgeInsets.zero,
                titleTextStyle: const TextStyle(color: Colors.white),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon:
                    const Icon(Icons.chevron_right, color: Colors.white),
                titleCentered: true,
                decoration: BoxDecoration(
                    color: const Color(0XFFBD818E),
                    borderRadius: BorderRadius.circular(8))),
            locale: 'es_EC',
            availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
            calendarBuilders:
                CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
              if (availableDays.any((availableDay) =>
                  availableDay.year == day.year &&
                  availableDay.month == day.month &&
                  availableDay.day == day.day)) {
                return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle),
                    child: Center(
                        child: Text(day.day.toString(),
                            style: const TextStyle(color: Colors.white))));
              }
              return null;
            }),
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
                context.read<ServicesSelectedBloc>().add(SelectDateTimeEvent(
                    listServicesSelected: state.listServicesSelected,
                    dateSelected: selectedDay,
                    timeSelected: state.timeSelected));
                _focusedDay = focusedDay;
              }
            },
            selectedDayPredicate: (day) => isSameDay(state.dateSelected, day),
            calendarFormat: CalendarFormat.month,
            calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                todayDecoration: BoxDecoration(
                    color: const Color(0XFFF3B4C7),
                    shape: BoxShape.circle),
                outsideDaysVisible: false,
                selectedDecoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle)),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            });
      }
      return const SizedBox.shrink();
    });
  }
}
