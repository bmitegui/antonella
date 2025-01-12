import 'package:antonella/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomPickDateWidget extends StatelessWidget {
  final String title;
  final DateTime? dateTime;
  final TimeOfDay? timeOfDay;
  final Function(DateTime) onSelectDate;
  final Function(TimeOfDay)? onSelectTime;
  const CustomPickDateWidget(
      {super.key,
      required this.title,
      required this.dateTime,
      this.timeOfDay,
      required this.onSelectDate,
      this.onSelectTime});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(title,
              style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.primary, fontWeight: FontWeight.bold))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton.icon(
            onPressed: () async {
              final dateTime = await _selectDate(context);
              if (dateTime != null) {
                onSelectDate(dateTime);
              }
            },
            label: Text(formatDateTime(dateTime), style: textTheme.bodyMedium),
            icon: Icon(Icons.calendar_month,
                color: colorScheme.onSurfaceVariant)),
        if (onSelectTime != null) const SizedBox(width: 8),
        if (onSelectTime != null)
          TextButton.icon(
              onPressed: () async {
                final time = await _selectTime(context);
                if (time != null) {
                  onSelectTime!(time);
                }
              },
              label: Text(
                  timeOfDay != null
                      ? _formatTimeOfDay(timeOfDay!)
                      : '-- : -- : -- a.m.',
                  style: textTheme.bodyMedium),
              icon: const Icon(Icons.watch_later))
      ])
    ]);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss a').format(dt);
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    return picked;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return picked;
  }
}
