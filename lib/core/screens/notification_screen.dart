import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
              onPressed: () async {
                await requestNotificationPermission(context);
                if (await isNotificationPermissionGranted()) {
                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).go('/signIn');
                }
              },
              child: Text('Activar notificaciones')),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: LottieBuilder.asset(
                          "assets/lottie/notification.json")),
                  const SizedBox(height: 32),
                  Text('¡No te pierdas de nada!',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Text(
                      'Configura las notificaciones push para que sepas cuándo te envían mensajes o te lleguen notificaciones.')
                ])));
  }
}
