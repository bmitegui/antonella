import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_title_separator_widget.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_services_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationServicesPage extends StatelessWidget {
  final Function() previousPage;
  final Function() onSend;
  const ConfirmationServicesPage({super.key, required this.previousPage, required this.onSend});

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
              CustomTitleSeparatorWidget(
                  text: 'Fecha solicitada:',
                  description: formatDateTime(state.dateSelected)),
              const SizedBox(height: 16),
              CustomTitleSeparatorWidget(
                  text: 'Horario solicitado:',
                  description: state.timeSelected ?? '-'),
              const SizedBox(height: 16),
              CustomTitleSeparatorWidget(
                  text: 'Valor aproximado:',
                  description: state.getSummedPriceRange()),
              const SizedBox(height: 16),
              const CustomTitleSeparatorWidget(text: 'Servicios seleccionados'),
              const SizedBox(height: 8),
              const Expanded(child: ListServicesSelectedWidget()),
              const SizedBox(height: 16),
              BottomButtonsSearchScreen(previousPage: previousPage, onSend: onSend)
            ]));
      }
      return const SizedBox.shrink();
    });
  }
}
