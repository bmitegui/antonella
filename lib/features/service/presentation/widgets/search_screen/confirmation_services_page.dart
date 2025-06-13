import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_services_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationServicesPage extends StatelessWidget {
  const ConfirmationServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              const ProgressSearchWidget(page: 4),
              const SizedBox(height: 16),
              CustomTitle(
                  title: 'Fecha solicitada:',
                  description: formatDateTime(state.dateSelected)),
              const SizedBox(height: 16),
              CustomTitle(
                  title: 'Horario solicitado:',
                  description: state.timeSelected ?? '-'),
              const SizedBox(height: 16),
              CustomTitle(
                  title: 'Valor aproximado:',
                  description: state.getSummedPriceRange()),
              const SizedBox(height: 16),
              CustomTitle(
                  title: 'Servicios seleccionados (${state.services.length})'),
              const SizedBox(height: 16),
              const Expanded(child: ListServicesSelectedWidget())
            ]));
      }
      return const SizedBox.shrink();
    });
  }
}
