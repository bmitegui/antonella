import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/icon_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesFilterWidget extends StatelessWidget {
  const ServicesFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: ServiceCategory.values.map((entry) {
            return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconServiceWidget(
                    onTap: () => context
                        .read<ServiceBloc>()
                        .add(GetServicesEvent(filter: entry)),
                    bottomTitle: getCategoryText(context: context, serviceCategory: entry) ,
                    asset: imagesServiceCategory[entry]!,
                    isSelected: (state is ServicesLoaded)
                        ? state.serviceCategory == entry
                        : false));
          }).toList()));
    });
  }
}
