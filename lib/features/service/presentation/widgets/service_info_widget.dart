import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/screens/detail_service_screen.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/service_image_network.dart';
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
        index = state.services
            .indexWhere((service) => service.id == serviceEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
              onTap: () {
                sl<CommentBloc>()
                    .add(GetServiceCommentsEvent(serviceId: serviceEntity.id));
                navigateWithSlideTransition(
                    context, DetailServiceScreen(serviceEntity: serviceEntity));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          isSelected ? Color(0xFFF44565) : Colors.transparent),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color:
                                            isSelected ? Colors.white : null))),
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
                                            ? Colors.white70
                                            : Colors.grey))),
                        const SizedBox(height: 8),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, bottom: 8),
                                child: Text(
                                    '\$${serviceEntity.minPrice} - ${serviceEntity.maxPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Color(0xFFF44565)))))
                      ]))));
    });
  }
}
