import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/screens/chat_screen/visualize_chat_user_screen.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Chats',
        child: Column(children: [
          infoChat(
              context: context,
              url:
                  'https://b2472105.smushcdn.com/2472105/wp-content/uploads/2022/11/10-Poses-para-foto-de-Perfil-Profesional-Mujer-04-2022-1-819x1024.jpg?lossy=1&strip=1&webp=1',
              title: 'Administrador',
              subtitle: 'C',
              pendingMessages: '4'),
        
        ]));
  }

  Widget infoChat(
      {required BuildContext context,
      required String url,
      required String title,
      required String subtitle,
      String? pendingMessages,
      bool check = false}) {
    return ListTile(
        onTap: () {
          Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const VisualizeChatUserScreen(),
        ),
      );
        },
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: 54,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fill,
                  url,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator());
                    }
                  },
                  errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.wifi_off_outlined,
                      color: Colors.grey,
                      size: 16.rh(context)))),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Row(children: [
                  if (check) Icon(Icons.check, size: 16, color: Colors.green),
                  Expanded(
                      child: Text(subtitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis))
                ])
              ]))
        ]),
        trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('11:06 am', style: Theme.of(context).textTheme.bodySmall),
              if (pendingMessages != null) const SizedBox(height: 4),
              if (pendingMessages != null)
                CircleAvatar(
                    radius: 8,
                    backgroundColor: const Color(0XFFBD818E),
                    child: Text(pendingMessages,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white)))
            ]));
  }
}
