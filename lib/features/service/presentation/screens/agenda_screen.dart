import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_widget.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: themeClass.lightscaffoldBackgroundColor,
            title: Text('Ver citas',
                style: Theme.of(context).textTheme.titleMedium),
            actions: [Image.asset('assets/icon/logo.png')]),
        body: const Padding(
            padding: EdgeInsets.only(right: 16, left: 16, top: 16),
            child: Column(children: [CustomTableCalendarWidget()])));
  }
}
