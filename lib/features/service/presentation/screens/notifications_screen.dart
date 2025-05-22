import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/widgets/custom_scrollview.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollviewImages()
      
    );
  }
}
