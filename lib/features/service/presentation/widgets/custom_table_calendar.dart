import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({super.key});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        TableCalendar(
            daysOfWeekHeight: 36,
            headerStyle: HeaderStyle(
                formatButtonVisible: false,
                headerMargin: const EdgeInsets.only(bottom: 8),
                leftChevronPadding: const EdgeInsets.symmetric(vertical: 8),
                rightChevronPadding: const EdgeInsets.symmetric(vertical: 8),
                headerPadding: const EdgeInsets.symmetric(horizontal: 48),
                titleTextStyle: const TextStyle(color: Colors.black),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.black),
                rightChevronIcon:
                     Icon(Icons.chevron_right, color: Colors.black),
                titleCentered: true),
            locale: 'es_EC',
            availableCalendarFormats: const {
              CalendarFormat.month: '',
              CalendarFormat.twoWeeks: ''
            },
            calendarFormat: _calendarFormat,
            calendarBuilders: CalendarBuilders(headerTitleBuilder: (context, day) {
              final month = _monthNameInSpanish(day.month).toUpperCase();
              return Text('$month ${day.year}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium);
            }, dowBuilder: (context, day) {
              final text = ['D', 'L', 'M', 'MI', 'J', 'V', 'S'][day.weekday % 7];
              return Container(
                  alignment: Alignment.center,
                  color: const Color(0xFFE596A9),
                  child: Text(text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)));
            }),
            focusedDay: _focusedDay ?? DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _calendarFormat = CalendarFormat.twoWeeks;
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            firstDay: DateTime.utc(2023),
            lastDay: DateTime.utc(2099),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                todayDecoration:
                    BoxDecoration(color: Color(0XFFF3B4C7), shape: BoxShape.circle),
                outsideDaysVisible: false,
                selectedDecoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            }),
                    Positioned(right: 0,top: 0,child: IconButton(onPressed: (){
          print('a');
        }, icon: Icon(Icons.fullscreen)))
      ]
    );
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
