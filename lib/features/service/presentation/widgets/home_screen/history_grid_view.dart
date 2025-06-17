import 'package:antonella/features/service/presentation/widgets/home_screen/history_container.dart';
import 'package:flutter/material.dart';

class HistoryGridView extends StatelessWidget {
  const HistoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> data = [
      {
        'title': 'Total Facturado',
        'valor': '\$325,75',
        'image': 'assets/svg/facturas.svg',
        'color': Color(0xFF009387)
      },
      {
        'title': 'Total Clientes',
        'valor': '26',
        'image': 'assets/svg/roles.svg',
        'color': Color(0xFF2995CD)
      },
      {
        'title': 'Total a Recibir',
        'valor': '\$250',
        'image': 'assets/svg/ganancias.svg',
        'color': Color(0xFF399F49)
      }
    ];
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
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
