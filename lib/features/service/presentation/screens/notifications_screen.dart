import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Notificaciones',
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child:
                      LottieBuilder.asset("assets/lottie/notification.json")),
              const SizedBox(height: 32),
              Text('Sin notificaciones',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Text('Te avisaremos cuando haya algo nuevo para ti.'),
              const SizedBox(height: 128)
            ]));
  }
}
