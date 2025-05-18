import 'package:antonella/features/service/presentation/widgets/service_image_network_image.dart';
import 'package:flutter/material.dart';

class ListChatsWidget extends StatelessWidget {
  const ListChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      infoChat(
          context: context,
          url:
              'https://b2472105.smushcdn.com/2472105/wp-content/uploads/2022/11/10-Poses-para-foto-de-Perfil-Profesional-Mujer-04-2022-1-819x1024.jpg?lossy=1&strip=1&webp=1',
          title: 'Sofía Hernández',
          subtitle: 'Profesional de cabello'),
      const SizedBox(height: 16),
      infoChat(
          context: context,
          url:'https://ntvb.tmsimg.com/assets/assets/720474_v9_bc.jpg',
          title: 'Sabrina Carpenter',
          subtitle: 'Profesional de uñas'),
      const SizedBox(height: 16),
      infoChat(
          context: context,
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRrJqk6q56_yFxyf124738UZSAaFKT_AqF3Q&s',
          title: 'Taylor Swift',
          subtitle: 'Profesional de spa')
    ]));
  }

  Widget infoChat(
      {required BuildContext context,
      required String url,
      required String title,
      required String subtitle}) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0XFF484850), width: 0.5)
            ),
        child: ListTile(
            title: Row(children: [
              ServiceImageNetworkImage(width: 64, height: 64, urlImage: url),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall)
                  ]))
            ]),
            trailing: Icon(Icons.arrow_forward_ios,
                color: const Color(0XFF484850)
                )
                ));
  }
}
