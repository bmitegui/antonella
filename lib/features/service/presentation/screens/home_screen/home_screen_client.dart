import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/home_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/products_tab_section.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_tab_section.dart';
import 'package:flutter/material.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({super.key});

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: BienvenidaWidget(),
        body: Column(children: [
          HomeTabBar(controller: _tabController),
          const SizedBox(height: 16),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: const [ServicesTabSection(), ProductsTabSection()]))
        ]));
  }
}
