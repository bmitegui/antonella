import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/cart_button.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_time_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/tab_section_page_view.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotions_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenClient extends StatelessWidget {
  const SearchScreenClient({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return CustomScaffold(
      noPaddingTitle: true,
      title: Row(children: [
        Text(texts.promotions, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        const CartButton()
      ]),
      body: TabSectionPageView(
        pages: [
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SelectDatePage(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SelectTimePage(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConfirmationServicesPage(),
          ),
        ],
        titleText: null,
        checkDateTime: true,
      ),
    );
  }
}
