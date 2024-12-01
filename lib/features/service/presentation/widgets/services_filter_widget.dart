import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/icon_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final servicesData = {
  'Todos': 'assets/icon/logo.png',
  'Maquillaje': 'assets/img/maquillaje.png',
  'Spa': 'assets/img/spa.png',
  'Uñas': 'assets/img/uñas.png',
  'Cabello': 'assets/img/cabello.png',
};

class ServicesFilterWidget extends StatelessWidget {
  const ServicesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: servicesData.entries.map((entry) {
            return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconServiceWidget(
                    onTap: () => context
                        .read<ServiceBloc>()
                        .add(GetServicesEvent(filter: entry.key)),
                    bottomTitle: entry.key,
                    asset: entry.value,
                    isSelected: (state is ServicesLoaded)
                        ? state.listServices.categorySelected == entry.key
                        : false));
          }).toList()));
    });
  }
}
