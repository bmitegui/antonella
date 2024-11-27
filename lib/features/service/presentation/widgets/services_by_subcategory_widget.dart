import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/service_info_widget.dart';
import 'package:flutter/material.dart';

class ServicesBySubcategoryWidget extends StatelessWidget {
  final String subCategory;
  final List<ServiceEntity> services;
  final List<String> servicesSelected;
  const ServicesBySubcategoryWidget(
      {super.key,
      required this.subCategory,
      required this.services,
      required this.servicesSelected});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
            color: themeClass.lightPrimaryColor,
            width: 4,
            child: Text('', style: Theme.of(context).textTheme.titleMedium)),
        const SizedBox(width: 4),
        Text(subCategory,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 8),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: services.map((service) {
            return ServiceInfoWidget(
                isSelected: servicesSelected.contains(service.id),
                urlImage: service.urlImage,
                name: service.name,
                description: service.description,
                minPrice: service.minPrice,
                maxPrice: service.maxPrice);
          }).toList()))
    ]);
  }
}
