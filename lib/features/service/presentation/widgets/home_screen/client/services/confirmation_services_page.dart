import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/list_services_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/progress_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationServicesPage extends StatelessWidget {
  const ConfirmationServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
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
                  title: texts.requested_date,
                  description: formatDateTime(state.dateSelected)),
              const SizedBox(height: 16),
              CustomTitle(
                  title: texts.requested_schedule,
                  description: state.timeSelected ?? '-'),
              const SizedBox(height: 16),
              CustomTitle(
                  title: texts.approximate_value,
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
