import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/features/service/presentation/widgets/service_image_network_image.dart';
import 'package:flutter/material.dart';

class ServiceInfoWidget extends StatelessWidget {
  final bool isSelected;
  final String urlImage;
  final String name;
  final String description;
  final double minPrice;
  final double maxPrice;
  const ServiceInfoWidget(
      {super.key,
      required this.isSelected,
      required this.urlImage,
      required this.name,
      required this.description,
      required this.minPrice,
      required this.maxPrice});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.only(right: 24, bottom: 16),
          child: GestureDetector(
            onTap: () {},
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
                      ServiceImageNetworkImage(urlImage: urlImage),
                      const SizedBox(height: 8),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : themeClass.lightEighthColor))),
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(description,
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
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 8),
                              child: Text('\$$minPrice - $maxPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : themeClass.lightPrimaryColor))))
                    ])),
          )),
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
  }
}