import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final List<OrderEntity> Function(DateTime)? eventLoader;
  final bool isProcess;
  const CustomTableCalendar(
      {super.key, this.eventLoader, this.isProcess = false});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  late CalendarFormat _calendarFormat;
  List<OrderEntity> _selectedorders = [];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    if (widget.eventLoader != null) {
      _selectedorders = widget.eventLoader!(_selectedDay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        _focusedDay = state.dateSelected ?? DateTime.now();
        _selectedDay = state.dateSelected ?? DateTime.now();
      }
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            TableCalendar(
                rowHeight: 48,
                eventLoader: widget.eventLoader,
                daysOfWeekHeight: 36,
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    headerMargin: const EdgeInsets.only(bottom: 8),
                    leftChevronPadding: const EdgeInsets.symmetric(vertical: 8),
                    rightChevronPadding:
                        const EdgeInsets.symmetric(vertical: 8),
                    headerPadding: const EdgeInsets.symmetric(horizontal: 48),
                    titleTextStyle: const TextStyle(color: Colors.black),
                    leftChevronIcon:
                        const Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon:
                        const Icon(Icons.chevron_right, color: Colors.black),
                    titleCentered: true),
                locale: 'es_EC',
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                  CalendarFormat.twoWeeks: ''
                },
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarBuilders:
                    CalendarBuilders(headerTitleBuilder: (context, day) {
                  final month = [
                    texts.january,
                    texts.february,
                    texts.march,
                    texts.april,
                    texts.may,
                    texts.june,
                    texts.july,
                    texts.august,
                    texts.september,
                    texts.october,
                    texts.november,
                    texts.december
                  ][(day.month) - 1]
                      .toUpperCase();
                  return GestureDetector(
                      onTap: () => setState(() {
                            _calendarFormat =
                                _calendarFormat == CalendarFormat.month
                                    ? CalendarFormat.twoWeeks
                                    : CalendarFormat.month;
                          }),
                      child: Text('$month ${day.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium));
                }, dowBuilder: (context, day) {
                  final text = [
                    texts.sunday,
                    texts.monday,
                    texts.tuesday,
                    texts.wednesday,
                    texts.thursday,
                    texts.friday,
                    texts.saturday
                  ][day.weekday % 7];
                  return Container(
                      alignment: Alignment.center,
                      color: const Color(0xFFE596A9),
                      child: Text(text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)));
                }),
                focusedDay: _focusedDay!,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedorders = widget.eventLoader != null
                        ? widget.eventLoader!(selectedDay)
                        : [];
                  });
                  if (widget.eventLoader == null) {
                    sl<ServicesSelectedBloc>()
                        .add(SelectDateTimeEvent(dateSelected: selectedDay));
                  }
                },
                firstDay: DateTime.utc(2024),
                lastDay: DateTime.utc(2099),
                calendarStyle: const CalendarStyle(
                    isTodayHighlighted: false,
                    todayDecoration: BoxDecoration(
                        color: Color(0XFFF3B4C7), shape: BoxShape.circle),
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle)),
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                }),
            const SizedBox(height: 16),
            if (_selectedorders.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedorders.length,
                  itemBuilder: (context, index) {
                    final orderEntity = _selectedorders[index];
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InfoOrderContainer(orderEntity: orderEntity));
                  })
            else if (widget.eventLoader != null && _selectedorders.isEmpty)
              Text(texts.no_appointments,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54))
          ]));
    });
  }
}
