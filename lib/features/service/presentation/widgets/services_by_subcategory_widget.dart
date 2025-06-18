import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/service_info_widget.dart';
import 'package:flutter/material.dart';

class ServicesBySubcategoryWidget extends StatelessWidget {
  final String subCategory;
  final List<ServiceEntity> services;
  const ServicesBySubcategoryWidget(
      {super.key, required this.subCategory, required this.services});

  @override
  Widget build(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTitle(title: subCategory),
      const SizedBox(height: 8),
      SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: services.map((service) {
          return ServiceInfoWidget(serviceEntity: service);
        }).toList()))
      
    ]);
  }
}
