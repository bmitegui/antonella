import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_events_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/status_legend_widget.dart';
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFF0F0F0),
            title: Text('Ver citas',
                style: Theme.of(context).textTheme.titleMedium),
            actions: [Image.asset('assets/icon/logo.png')]),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(children: [
              TabBar(
                  controller: _tabController,
                  labelColor: const Color(0XFF484850),
                  tabs: const [
                    Tab(text: 'Reservadas'),
                    Tab(text: 'Pendientes')
                  ]),
              const SizedBox(height: 16),
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: const [
                    CustomTableCalendarEventsWidget(),
                    CustomTableCalendarEventsWidget()
                  ]))
            ])));
  }
}
