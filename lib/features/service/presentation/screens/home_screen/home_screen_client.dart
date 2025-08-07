import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/home_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/products_tab_section.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_tab_section.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotion_view_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowPromo();
    });
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

  Future<void> _checkAndShowPromo() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Leer la fecha del primer día que se mostró
    String? startDateStr = prefs.getString('promo_start_date');
    String? lastShown = prefs.getString('last_promo_date');

    DateTime todayDate = DateTime.now();

    // Si no hay fecha de inicio guardada, la creamos hoy
    if (startDateStr == null) {
      await prefs.setString('promo_start_date', today);
      startDateStr = today;
    }

    // Parsear la fecha de inicio
    final startDate = DateFormat('yyyy-MM-dd').parse(startDateStr);

    // Calcular días transcurridos
    final daysSinceStart = todayDate.difference(startDate).inDays;

    //_showPromotionDialog();

    if (daysSinceStart < 5 && lastShown != today) {
      _showPromotionDialog();
      await prefs.setString('last_promo_date', today);
    }

    // Si ya pasaron más de 5 días, no hacemos nada
  }

  void _showPromotionDialog() {
    showDialog(
        context: context,
        builder: (context) => BlocBuilder<PromotionBloc, PromotionState>(
                builder: (context, state) {
              if (state is PromotionLoaded) {
                return AlertDialog(
                  title: const Text("🎉 ¡Promoción por tiempo limitado!"),
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (state.listPromotions.isNotEmpty)
                          ? SizedBox(
                              width: 200,
                              height: 300,
                              child: Image.network(
                                Environment.apiUrl +
                                    state.listPromotions.last.images.first,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 300,
                              ))
                          : SizedBox.shrink()
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar"),
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        navigateWithSlideTransition(
                            context,
                            PromotionViewDetails(
                                promotionEntity: state.listPromotions.last));
                      },
                      text: "Ver más",
                    ),
                  ],
                );
              } else if (state is PromotionError) {
                return Center(
                    child: Text(mapFailureToMessage(
                        context: context, failure: state.failure)));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
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
