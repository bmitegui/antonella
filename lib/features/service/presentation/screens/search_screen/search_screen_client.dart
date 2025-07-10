import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_search_widget.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/service/service_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_filter_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotions_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenClient extends StatefulWidget {
  const SearchScreenClient({super.key});

  @override
  State<SearchScreenClient> createState() => _SearchScreenClientState();
}

class _SearchScreenClientState extends State<SearchScreenClient> {
  // final listPromotions = [
  //   PromotionEntity(
  //       id: 'id',
  //       name: 'name',
  //       description: 'description',
  //       imageUrl:
  //           'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p1.jpg?alt=media&token=fc26e7a3-415d-4cfa-bb09-270546e09b88',
  //       categoryServices: [ServiceType.hair, ServiceType.nails]),
  //   PromotionEntity(
  //       id: 'id',
  //       name: 'name',
  //       description: 'description',
  //       imageUrl:
  //           'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p2.jpg?alt=media&token=0e551465-1d6e-4885-8e97-68bd987ee9ea',
  //       categoryServices: [ServiceType.spa]),
  //   PromotionEntity(
  //       id: 'id',
  //       name: 'name',
  //       imageUrl:
  //           'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p3.jpg?alt=media&token=86f4d4b9-6883-4298-8cf7-ec27e052bc4e',
  //       description: 'description',
  //       categoryServices: [
  //         ServiceType.hair,
  //         ServiceType.nails,
  //         ServiceType.spa,
  //         ServiceType.makeup
  //       ]),
  //   PromotionEntity(
  //       id: 'id',
  //       name: 'name',
  //       imageUrl:
  //           'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p4.jpg?alt=media&token=ab842ea5-3455-4a31-a35c-e0d97898b0c5',
  //       description: 'description',
  //       categoryServices: [ServiceType.hair]),
  //   PromotionEntity(
  //       id: 'id',
  //       name: 'name',
  //       imageUrl:
  //           'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p5.jpg?alt=media&token=815d6272-c9ac-49e2-ade7-b98ae734a565',
  //       description: 'description',
  //       categoryServices: [ServiceType.nails])
  // ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Promociones',
        body: BlocBuilder<PromotionBloc, PromotionState>(
            builder: (context, state) {
          List<PromotionEntity>? filteredPromotions;
          if (state is PromotionLoaded) {
            filteredPromotions = state.listPromotions;
          }
          return RefreshIndicator(
            onRefresh: () async =>sl<PromotionBloc>().add(GetPromotionsEvent()),
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                child: (state is PromotionLoaded)
                    ? (state.listPromotions.isNotEmpty)
                        ? Expanded(
                          child: PromotionsGridView(
                              listPromotions: filteredPromotions!),
                        )
                        : Center(
                            child:
                                Text('No existe promociones en este momento'))
                    : (state is PromotionError)
                        ? Text(mapFailureToMessage(
                            context: context, failure: state.failure))
                        : Center(child: CircularProgressIndicator())),
          );
        }));
  }
}
