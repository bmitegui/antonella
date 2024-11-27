import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';

class ServiceImageNetworkImage extends StatelessWidget {
  final String urlImage;
  const ServiceImageNetworkImage({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2.2;
    final height = MediaQuery.of(context).size.height / 5;
    return Center(
        child: Container(
            clipBehavior: Clip.hardEdge,
            width: width,
            height: height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.network(
                filterQuality: FilterQuality.low,
                fit: BoxFit.fill,
                urlImage,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Padding(
                        padding: EdgeInsets.all(64),
                        child: CircularProgressIndicator());
                  }
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.wifi_off_outlined,
                    color: Colors.grey,
                    size: 64.rh(context)))));
  }
}
