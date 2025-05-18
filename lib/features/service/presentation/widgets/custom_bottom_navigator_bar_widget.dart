import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigatorBarWidget extends StatelessWidget {
  final Function(int) onTabChange;
  const CustomBottomNavigatorBarWidget({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(8),
            child: GNav(
                tabBorderRadius: 8,
                backgroundColor: const Color(0XFFAF234A),
                activeColor: Colors.white,
                color: Colors.white,
                tabBackgroundColor: const Color(0XFFBD818E),
                gap: 4,
                padding: const EdgeInsets.all(4),
                onTabChange: onTabChange,
                tabs: const [
                  GButton(icon: Icons.home_rounded, text: 'Inicio'),
                  GButton(icon: Icons.search, text: 'Buscar'),
                  GButton(icon: Icons.calendar_month, text: 'Agenda'),
                  GButton(icon: Icons.notifications_rounded, text: 'Alertas'),
                  GButton(icon: Icons.chat, text: 'Chats'),
                  GButton(icon: Icons.settings_rounded, text: 'Ajustes')
                ])));
  }
}
