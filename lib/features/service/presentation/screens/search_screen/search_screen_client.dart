import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/cart_button.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotions_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenClient extends StatefulWidget {
  const SearchScreenClient({super.key});

  @override
  State<SearchScreenClient> createState() => _SearchScreenClientState();
}

class _SearchScreenClientState extends State<SearchScreenClient> {
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        text: texts.promotions,
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 80, right: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CartButton()
            ])),
        body: BlocBuilder<PromotionBloc, PromotionState>(
            builder: (context, state) {
          List<PromotionEntity>? filteredPromotions;
          if (state is PromotionLoaded) {
            filteredPromotions = state.listPromotions;
          }
          return RefreshIndicator(
            onRefresh: () async =>
                sl<PromotionBloc>().add(GetPromotionsEvent()),
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                child: (state is PromotionLoaded)
                    ? (state.listPromotions.isNotEmpty)
                        ? PromotionsGridView(
                            listPromotions: filteredPromotions!)
                        : Center(child: Text(texts.no_promotions))
                    : (state is PromotionError)
                        ? Text(mapFailureToMessage(
                            context: context, failure: state.failure))
                        : Center(child: CircularProgressIndicator())),
          );
        }));
  }
}
