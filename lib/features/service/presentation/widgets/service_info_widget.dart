import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/form_service_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/service_image_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceInfoWidget extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ServiceInfoWidget({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      int index = -1;

      bool isSelected = false;
      if (state is ServicesSelectedLoaded) {
        index = state.listServicesSelected
            .indexWhere((service) => service.id == serviceEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return Stack(children: [
        Padding(
            padding: const EdgeInsets.only(right: 24, bottom: 16),
            child: GestureDetector(
                onTap: () async {
                  if (state is ServicesSelectedLoaded) {
                    sl<ServiceFormBloc>().add(GetListServiceFormEvent(
                        serviceEntity: isSelected
                            ? state.listServicesSelected[index]
                            : serviceEntity));

                    await showModalBottomSheet<List>(
                        scrollControlDisabledMaxHeightRatio: 1,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return FormServiceSelectedWidget(
                              serviceEntity: isSelected
                                  ? state.listServicesSelected[index]
                                  : serviceEntity);
                        });
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected ? Colors.green : Colors.grey.shade50,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 2),
                              blurRadius: 1)
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          ServiceImageNetworkImage(
                              urlImage: serviceEntity.urlImage),
                          const SizedBox(height: 8),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(serviceEntity.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.amber))),
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(serviceEntity.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: isSelected
                                                  ? Colors.white70
                                                  : Colors.black54)))),
                          const SizedBox(height: 8),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  child: Text(
                                      '\$${serviceEntity.minPrice} - ${serviceEntity.maxPrice}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith())))
                        ])))),
        if (isSelected)
          const Positioned(
              top: 16,
              right: 40,
              child: CustomCircularIconButtom(
                  padding: EdgeInsets.all(4),
                  borderColor: Colors.transparent,
                  icon: Icon(Icons.check, color: Colors.white),
                  color: Colors.green))
      ]);
    });
  }
}
