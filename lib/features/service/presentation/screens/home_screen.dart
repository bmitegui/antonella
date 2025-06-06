import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/home_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/products_tab_section.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/services_tab_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
            backgroundColor: Color(0xFFF0F0F0),
            title: const BienvenidaWidget()),
        body: Padding(
            padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
            child: Column(children: [
              HomeTabBar(controller: _tabController),
              const SizedBox(height: 16),
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: const [
                    ServicesTabSection(),
                    ProductsTabSection()
                  ]))
            ])));
  }
}
