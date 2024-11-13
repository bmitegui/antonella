import 'package:flutter/material.dart';

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        radius: 80, backgroundImage: AssetImage('assets/img/placeholder.jpg'));
  }
}
