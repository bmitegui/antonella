import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/screens/detail_service_screen.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/service_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceInfoWidget extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ServiceInfoWidget({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      int index = -1;

      bool isSelected = false;
      if (state is ServicesSelectedLoaded) {
        index = state.services
            .indexWhere((service) => service.id == serviceEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
              onTap: () {
                sl<CommentBloc>()
                    .add(GetServiceCommentsEvent(serviceId: serviceEntity.id));
                navigateWithSlideTransition(
                    context, DetailServiceScreen(serviceEntity: serviceEntity));
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onPrimary),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        ServiceImageNetwork(
                            urlImage:
                                Environment.apiUrl + serviceEntity.images[0]),
                        const SizedBox(height: 8),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(serviceEntity.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: isSelected
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurface))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(serviceEntity.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: isSelected
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurfaceVariant))),
                        const SizedBox(height: 8),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(children: [
                              Text(
                                  '\$${serviceEntity.minPrice} - ${serviceEntity.maxPrice}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: isSelected
                                              ? colorScheme.onPrimary
                                              : colorScheme.primary)),
                              Spacer(),
                              Icon(Icons.star_rounded, color: Colors.amber),
                              Text('${serviceEntity.rating}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: colorScheme.onSurface))
                            ]))
                      ]))));
    });
  }
}
