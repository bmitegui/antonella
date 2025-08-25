import 'package:antonella/features/service/presentation/widgets/home_screen/history_container.dart';
import 'package:flutter/material.dart';

class ShimmerHistoryGridView extends StatelessWidget {
  final List<dynamic> data;
  const ShimmerHistoryGridView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 100,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              final title = data[index]['title']!;
              final valor = data[index]['valor']!;
              final image = data[index]['image']!;
              final color = data[index]['color']!;
              return HistoryContainer(
                  title: title, valor: valor, image: image, color: color);
            }));
  }
}
