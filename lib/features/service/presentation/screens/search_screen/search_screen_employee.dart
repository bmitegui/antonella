import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/employee/filter_label_appoinment.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/employee/status_label_appointment.dart';
import 'package:flutter/material.dart';

class SearchScreenEmployee extends StatelessWidget {
  const SearchScreenEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Buscar cita',
        child: Column(children: [
          CustomTitle(title: 'Estados'),
          const SizedBox(height: 16),
          StatusLabelAppointment(),
          const SizedBox(height: 16),
          CustomTitle(title: 'Ordenar'),
          const SizedBox(height: 16),
          FilterLabelAppoinment(),
          const SizedBox(height: 16),
          CustomTitle(title: 'Citas'),
          const SizedBox(height: 16),
        ]));
  }
}
