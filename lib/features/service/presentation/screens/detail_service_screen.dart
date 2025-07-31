import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/service_form/service_form_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/description_service_section.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/detail_service_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/service_comments_list.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/label_detail_service_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_service_selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailServiceScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;
  const DetailServiceScreen({super.key, required this.serviceEntity});

  @override
  State<DetailServiceScreen> createState() => _DetailServiceScreenState();
}

class _DetailServiceScreenState extends State<DetailServiceScreen>
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
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      int index = -1;

      bool isSelected = false;
      if (state is ServicesSelectedLoaded) {
        index = state.services
            .indexWhere((service) => service.id == widget.serviceEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return CustomScaffold(
          paddingScroll: EdgeInsets.all(0),
          leading: ArrowBack(),
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
                        '\$${widget.serviceEntity.minPrice} - ${widget.serviceEntity.maxPrice}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    CustomElevatedButton(
                        onPressed: () async {
                          if (state is ServicesSelectedLoaded) {
                            final serviceSelected = isSelected
                                ? state.services[index]
                                : widget.serviceEntity;
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
                        text: texts.add_service,)
                  ])),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImagesScrollview(images: widget.serviceEntity.images),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.serviceEntity.subtype,
                          style: titleBlack54Style(context)),
                      SizedBox(height: 8),
                      Text(widget.serviceEntity.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: colorScheme.onSurface)),
                      SizedBox(height: 8),
                      LabelDetailServiceWidget(
                          category: getCategoryText(
                              context: context,
                              serviceCategory: widget.serviceEntity.type),
                          rating: widget.serviceEntity.rating,
                          duration: widget.serviceEntity.duration),
                    ])),
            SizedBox(height: 8),
            DetailServiceTabBar(controller: _tabController),
            const SizedBox(height: 16),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              DescriptionServiceSection(
                  description: widget.serviceEntity.description),
              ServiceCommentsSection()
            ]))
          ]));
    });
  }
}
