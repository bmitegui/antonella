import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/progress_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/time_picker.dart';
import 'package:flutter/material.dart';

class SelectTimePage extends StatelessWidget {
  const SelectTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 3),
          const SizedBox(height: 16),
          Text(
              ' Seleccione una hora que prefiera deslizando la pantalla para reservar la cita, y luego continue'),
          const SizedBox(height: 32),
          TimePicker()
        ]));
  }
}
