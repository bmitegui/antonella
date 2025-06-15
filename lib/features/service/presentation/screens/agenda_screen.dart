import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_events_widget.dart';
import 'package:antonella/features/service/presentation/widgets/service_to_confirm_widget.dart';
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
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F0F0),
        title: Text('Agenda',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF44565))),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: const Color(0XFF484850),
                tabs: [
                  const Tab(text: 'Agendados'),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Por Confirmar'),
                        SizedBox(width: 4),
                        if (number > 9)
                          logoCantidad(number, 30)
                        else if (number > 0)
                          logoCantidad(number, 20)
                      ],
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const CustomTableCalendarEventsWidget(),
                    number > 0 ? ServiceToConfirmWidget(quantity: number) : const Center(child: Text('No hay citas por confirmar'))
                  ]
                )
              )
            ],
          ),
        ),
      );
  }
}

Widget logoCantidad(int number, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.only(left: 6),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFF44565)
    ),
    child: Text(number.toString(), style: TextStyle(color: Colors.white)),
  );
}
