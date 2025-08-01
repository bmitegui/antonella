import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/comment/comment_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/screens/detail_service_screen.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/label_detail_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicePromotionInfo extends StatelessWidget {
  final ServiceEntity service;
  final ServiceItemEntity serviceItemEntity;

  const ServicePromotionInfo(
      {super.key, required this.service, required this.serviceItemEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      bool isSelected = false;
      if (state is ServicesSelectedLoaded) {
        final index =
            state.services.indexWhere((service) => service.id == service.id);
        if (index != -1) {
          isSelected = true;
        }
      }
      return GestureDetector(
          onTap: () {
            sl<CommentBloc>()
                .add(GetServiceCommentsEvent(serviceId: service.id));
            navigateWithSlideTransition(
                context, DetailServiceScreen(serviceEntity: service));
          },
          child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(service.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(service.description,
                              maxLines: 3, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 8),
                          LabelDetailServiceWidget(
                              category: getCategoryText(
                                  context: context,
                                  serviceCategory: service.type),
                              rating: service.rating,
                              duration: service.duration),
                          const SizedBox(height: 8),
                          if (serviceItemEntity.discount != null)
                            Text(
                                "Descuento: ${serviceItemEntity.discount! * 100}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.red)),
                          if (serviceItemEntity.fixedAmount != null)
                            Text(
                                "Monto fijo: \$${serviceItemEntity.fixedAmount}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.red))
                        ])),
                if (isSelected)
                  Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(Icons.check_box, color: Colors.green))
              ])));
    });
  }
}
