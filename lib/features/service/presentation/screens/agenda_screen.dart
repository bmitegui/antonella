import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/agenda_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_events_widget.dart';
import 'package:antonella/features/service/presentation/widgets/list_service_to_confirm.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int number = 2;

    return CustomScaffold(
        text: 'Agenda',
        body: Column(children: [
          AgendaTabBar(controller: _tabController),
          const SizedBox(height: 16),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            const CustomTableCalendarEventsWidget(),
            number > 0
                ? ListServiceToConfirm(quantity: number)
                : const Center(child: Text('No hay citas por confirmar'))
          ]))
        ]));
  }
}
