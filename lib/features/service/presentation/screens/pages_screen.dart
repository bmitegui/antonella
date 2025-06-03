import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/screens/agenda_screen.dart';
import 'package:antonella/features/service/presentation/screens/chats_screen.dart';
import 'package:antonella/features/service/presentation/screens/home_screen.dart';
import 'package:antonella/features/service/presentation/screens/notifications_screen.dart';
import 'package:antonella/features/service/presentation/screens/search_screen.dart';
import 'package:antonella/features/service/presentation/widgets/custom_bottom_navigator_bar_widget.dart';
import 'package:antonella/features/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({super.key});

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  late PageController _pageController;
  late int _currentIndex;

  final List<Widget> _contentPages = const [
    AgendaScreen(),
    SearchScreen(),
    HomeScreen(),
    ChatsScreen(),
    NotificationsScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    _currentIndex = 2;
    _pageController.addListener(_handleTabSelection);
    sl<ServiceBloc>().add(GetServicesEvent(filter: ServiceCategory.all));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _contentPages.map((Widget content) {
              return content;
            }).toList()),
        bottomNavigationBar: CustomBottomNavigatorBarWidget(
            activeIndex: _currentIndex,
            onTabChange: (index) {
              FocusScope.of(context).unfocus();
              _currentIndex = index;
              _pageController.jumpToPage(index);
            }));
  }
}
