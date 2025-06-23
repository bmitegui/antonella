import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_search_widget.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/service/service_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotions_grid_view.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final listPromotions = [
    PromotionEntity(
        id: 'id',
        name: 'name',
        description: 'description',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p1.jpg?alt=media&token=fc26e7a3-415d-4cfa-bb09-270546e09b88',
        categories: [ServiceType.hair, ServiceType.nails]),
    PromotionEntity(
        id: 'id',
        name: 'name',
        description: 'description',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p2.jpg?alt=media&token=0e551465-1d6e-4885-8e97-68bd987ee9ea',
        categories: [ServiceType.spa]),
    PromotionEntity(
        id: 'id',
        name: 'name',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p3.jpg?alt=media&token=86f4d4b9-6883-4298-8cf7-ec27e052bc4e',
        description: 'description',
        categories: [
          ServiceType.hair,
          ServiceType.nails,
          ServiceType.spa,
          ServiceType.makeup
        ]),
    PromotionEntity(
        id: 'id',
        name: 'name',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p4.jpg?alt=media&token=ab842ea5-3455-4a31-a35c-e0d97898b0c5',
        description: 'description',
        categories: [ServiceType.hair]),
    PromotionEntity(
        id: 'id',
        name: 'name',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/antonella-b58e2.firebasestorage.app/o/p5.jpg?alt=media&token=815d6272-c9ac-49e2-ade7-b98ae734a565',
        description: 'description',
        categories: [ServiceType.nails])
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Promociones',
        body: BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
          final List<PromotionEntity> filteredPromotions =
              (state is ServicesLoaded)
                  ? (state.serviceType == ServiceType.all
                      ? listPromotions
                      : listPromotions
                          .where((promotion) =>
                              promotion.categories.contains(state.serviceType))
                          .toList())
                  : [];
          final category = (state is ServicesLoaded)
              ? getCategoryText(
                  context: context, serviceCategory: state.serviceType)
              : '';
          return Padding(
              padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Column(children: [
                CustomSearchWidget(),
                const SizedBox(height: 16),
                ServicesFilterWidget(),
                const SizedBox(height: 16),
                (state is ServicesLoaded)
                    ? CustomTitle(title: category)
                    : SizedBox.shrink(),
                const SizedBox(height: 16),
                (state is ServicesLoaded)
                    ? Expanded(
                        child: PromotionsGridView(
                            listPromotions: filteredPromotions))
                    : (state is ServicesError)
                        ? Text(state.message)
                        : CircularProgressIndicator()
              ]));
        }));
  }
}
