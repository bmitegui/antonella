import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/services_by_subcategory_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesInfoWidget extends StatelessWidget {
  const ServicesInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      return (state is ServicesLoaded)
          ? (state.listServices.services.isNotEmpty)
              ? RefreshIndicator(
                  onRefresh: () async => context
                      .read<ServiceBloc>()
                      .add(GetServicesEvent(filter: ServiceCategory.all)),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state
                              .getDataBySubCategories()
                              .entries
                              .map((entry) {
                            return ServicesBySubcategoryWidget(
                                subCategory: entry.key, services: entry.value);
                          }).toList())))
              : const Center(
                  child: Text('No existen servicios para esta categoría'))
          : (state is ServicesError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
