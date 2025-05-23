import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> imageLinks = ['https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRIOWX-41syp4c2OU8JH4bNW139mmqQmYNlIHTYU4k213JktKInLLztdvLA3QHRq3X1HC9IxIBdUrpYW3IOJI2lrb0t1dZAiNdsbjcfnw',
  'https://cdn.pixabay.com/photo/2021/05/25/07/21/children-day-6281611_1280.jpg', 'https://cdn.pixabay.com/photo/2020/06/05/17/41/child-5263902_1280.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
              ImagesScrollview(imageLinks: imageLinks),
              SizedBox(height: 16),
              ActivityStateWidget()
            ]));
  }
}
