import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/service_form/service_form_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/service_comments_list.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/label_detail_service_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_service_selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailServiceScreen extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const DetailServiceScreen({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      int index = -1;

      bool isSelected = false;
      if (state is ServicesSelectedLoaded) {
        index = state.services
            .indexWhere((service) => service.id == serviceEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return CustomScaffold(
          paddingScroll: EdgeInsets.all(0),
          leading: ArrowBack(),
          text: 'Detalles',
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '\$${serviceEntity.minPrice} - ${serviceEntity.maxPrice}',
                        style: Theme.of(context).textTheme.titleMedium),
                    CustomElevatedButton(
                        onPressed: () async {
                          if (state is ServicesSelectedLoaded) {
                            final serviceSelected = isSelected
                                ? state.services[index]
                                : serviceEntity;
                            sl<ServiceFormBloc>().add(
                                SelectServiceEvent(service: serviceSelected));
                            await showModalBottomSheet<List>(
                                scrollControlDisabledMaxHeightRatio: 1,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (BuildContext context) {
                                  return FormServiceSelectedWidget();
                                });
                          }
                        },
                        text: 'Agregar Servicio')
                  ])),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImagesScrollview(images: serviceEntity.images),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(serviceEntity.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Color(0xFFF44565))),
                      SizedBox(height: 8),
                      Text(serviceEntity.subtype,
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 8),
                      LabelDetailServiceWidget(
                          category: getCategoryText(
                              context: context,
                              serviceCategory: serviceEntity.type),
                          rating: serviceEntity.rating,
                          duration: serviceEntity.duration),
                      SizedBox(height: 8),
                      Text(serviceEntity.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey)),
                      SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Calificaciones y Opiniones',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Color(0xFFF44565))),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward,
                                    color: Color(0xFFF44565)))
                          ]),
                      ServiceCommentsList()
                    ]))
          ]));
    });
  }
}
