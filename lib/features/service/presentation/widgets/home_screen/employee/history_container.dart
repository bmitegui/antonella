import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:flutter/material.dart';

class HistoryContainer extends StatelessWidget {
  final String title;
  final String valor;
  final String image;
  final Color color;
  const HistoryContainer(
      {super.key,
      required this.title,
      required this.valor,
      required this.image,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          CustomLocalImage(assetPath: image, width: 40),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text(title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(valor,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold))
              ]))
        ]));
  }
}
