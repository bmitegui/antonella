import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/icon_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesFilterWidget extends StatelessWidget {
  const ServicesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {

      return (state is ServicesLoaded)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: state.services.map((service) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconServiceWidget(
                    onTap: (){

                    },
                      bottomTitle: service.name,
                      asset: service.asset,
                      isSelected: service.isSelected),
                );
              }).toList()))
          : const SizedBox.shrink();
    });
  }
}
