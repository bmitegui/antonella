import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_by_subcategory_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesInfoWidget extends StatelessWidget {
  const ServicesInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      return (state is ServicesLoaded)
          ? (state.listServices.services.isNotEmpty)
              ? RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ServiceBloc>().add(GetServicesEvent()),
                  child: BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
                    builder: (context, selectedState) {
                      return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 100),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state
                                  .getDataBySubCategories()
                                  .entries
                                  .map((entry) {
                                    final services = List.of(entry.value);
                                    
                                    List<String> selectedIds = [];
                                    if(selectedState is ServicesSelectedLoaded) {
                                      selectedIds = selectedState.services.map((s) => s.id).toList();
                                    }
                      
                                    services.sort((a, b) {
                                      final aSelected = selectedIds.contains(a.id);
                                      final bSelected = selectedIds.contains(b.id);
                      
                                      if (aSelected && !bSelected) return -1;
                                      if (!aSelected && bSelected) return 1;
                                      return 0;
                                    });
                      
                                    return ServicesBySubcategoryWidget(
                                        subCategory: entry.key, services: services);
                                  }).toList()));
                    }
                  ))
              : Center(child: Text(texts.no_service_for_category))
          : (state is ServicesError)
              ? Center(
                  child: Text(mapFailureToMessage(
                      context: context, failure: state.failure)))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
