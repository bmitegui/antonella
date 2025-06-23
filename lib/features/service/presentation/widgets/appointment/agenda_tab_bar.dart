import 'package:antonella/core/widgets/custom_tab.dart';
import 'package:flutter/material.dart';

class AgendaTabBar extends StatelessWidget {
  final TabController controller;
  const AgendaTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        unselectedLabelColor: Colors.black,
        indicatorColor: Color(0XFFF44565),
        dividerColor: Colors.grey.shade400,
        controller: controller,
        labelColor: Color(0XFFF44565),
        tabs: const [
          CustomTab(text: 'Agendados'),
          CustomTab(text: 'Por confirmar', number: 2)
        ]);
  }
}
