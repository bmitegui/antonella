import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class ServicesGroup extends StatelessWidget {
  final List<ServiceType> servicesTypes;
  const ServicesGroup({super.key, required this.servicesTypes});

  @override
  Widget build(BuildContext context) {
    return (servicesTypes.length > 1)
        ? CustomLocalSvgImage(
            assetPath: imagesServiceCategory[ServiceType.all]!)
        : CustomLocalSvgImage(
            assetPath: imagesServiceCategory[servicesTypes[0]]!);
  }
}
