import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/cart_button.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_time_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotions_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchScreenClient extends StatefulWidget {
  const SearchScreenClient({super.key});

  @override
  State<SearchScreenClient> createState() => _SearchScreenClientState();
}

class _SearchScreenClientState extends State<SearchScreenClient> {
  late PageController _pageController;
  int _currentPage = 0;
  Key _pageViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      final state = sl<ServicesSelectedBloc>().state;
      if (state is ServicesSelectedLoaded) {
        if (state.dateSelected == null) {
          sl<ServicesSelectedBloc>()
              .add(SelectDateTimeEvent(dateSelected: DateTime.now()));
        }
        if (state.timeSelected == null) {
          sl<ServicesSelectedBloc>().add(SelectTimeEvent(
              timeSelected: DateFormat('HH:mm').format(DateTime.now())));
        }
      }

      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      final state = sl<ServicesSelectedBloc>().state;
      if (state is ServicesSelectedLoaded) {
        if (state.dateSelected == null) {
          sl<ServicesSelectedBloc>()
              .add(SelectDateTimeEvent(dateSelected: DateTime.now()));
        }
        if (state.timeSelected == null) {
          sl<ServicesSelectedBloc>().add(SelectTimeEvent(
              timeSelected: DateFormat('HH:mm').format(DateTime.now())));
        }
      }

      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _sendRequest() {
    _pageViewKey = UniqueKey();
    _currentPage = 0;
    _pageController.dispose();
    _pageController = PageController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return CustomScaffold(
      title: Row(children: [
        Text(texts.promotions, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        const CartButton()
      ]),
      leading: _currentPage != 0 ? ArrowBack(onBack: _previousPage) : null,
      body: Column(children: [
        Expanded(
            child: PageView(
          key: _pageViewKey,
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentPage = index),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            /// Página 0: Grid de Promociones
            BlocBuilder<PromotionBloc, PromotionState>(
              builder: (context, state) {
                if (state is PromotionLoaded) {
                  return (state.listPromotions.isNotEmpty)
                      ? PromotionsGridView(listPromotions: state.listPromotions)
                      : Center(child: Text(texts.no_promotions));
                } else if (state is PromotionError) {
                  return Center(
                      child: Text(mapFailureToMessage(
                          context: context, failure: state.failure)));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

            /// Página 1: Selección de Fecha
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SelectDatePage(),
            ),

            /// Página 2: Selección de Hora
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SelectTimePage(),
            ),

            /// Página 3: Confirmación
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ConfirmationServicesPage(),
            ),
          ],
        )),

        /// Botones inferiores (Siguiente, Anterior, Enviar)
        BottomButtonsSearchScreen(
          currentPage: _currentPage,
          nextPage: _nextPage,
          previousPage: _previousPage,
          sendRequest: _sendRequest,
        ),
      ]),
    );
  }
}
