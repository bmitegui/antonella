import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigatorBarWidget extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabChange;
  const CustomBottomNavigatorBarWidget(
      {super.key, required this.activeIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
        onTap: onTabChange,
        activeIndex: activeIndex,
        activeIcons: const [
          Icon(Icons.calendar_month, color: Color(0xFFF44565)),
          Icon(Icons.search, color: Color(0xFFF44565)),
          Icon(Icons.home_rounded, color: Color(0xFFF44565)),
          Icon(Icons.chat, color: Color(0xFFF44565)),
          Icon(Icons.notifications_rounded, color: Color(0xFFF44565)),
          Icon(Icons.settings_rounded, color: Color(0xFFF44565)),
        ],
        inactiveIcons: const [
          Icon(Icons.calendar_month, color: Color(0XFFCACACA)),
          Icon(Icons.search, color: Color(0XFFCACACA)),
          Icon(Icons.home_rounded, color: Color(0XFFCACACA)),
          Icon(Icons.chat, color: Color(0XFFCACACA)),
          Icon(Icons.notifications_rounded, color: Color(0XFFCACACA)),
          Icon(Icons.settings_rounded, color: Color(0XFFCACACA)),
        ],
        color: Colors.white);
  }
}
