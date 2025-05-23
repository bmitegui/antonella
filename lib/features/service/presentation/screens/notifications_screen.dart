import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      ImagesScrollview(imageLinks: [
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
        'https://www.esteticalink.com/wp-content/uploads/2017/04/masaje-pies.jpg'
      ]),
      const SizedBox(height: 16),
      ActivityStateWidget()
    ]));
  }
}
