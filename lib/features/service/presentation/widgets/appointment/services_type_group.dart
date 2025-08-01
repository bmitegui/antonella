import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class ServicestypeGroup extends StatelessWidget {
  final List<ServiceType> servicesType;

  const ServicestypeGroup({super.key, required this.servicesType});

  @override
  Widget build(BuildContext context) {
    final visibleServices = servicesType.take(4).toList();

    return SizedBox(
        height: 80,
        width: double.infinity,
        child: Stack(
            children: List.generate(visibleServices.length, (index) {
          return Positioned(
              left: index * 32.0, // desplazamiento horizontal dinámico
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0XFFF44565),width: 3)),
                  child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomLocalImage(
                              assetPath: imagesServiceCategory[
                                  visibleServices[index]]!)))));
        })));
  }
}
