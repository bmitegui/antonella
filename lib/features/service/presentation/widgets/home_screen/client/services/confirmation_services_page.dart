import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/list_services_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/products_selected_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationServicesPage extends StatefulWidget {
  const ConfirmationServicesPage({super.key});

  @override
  State<ConfirmationServicesPage> createState() =>
      _ConfirmationServicesPageState();
}

class _ConfirmationServicesPageState extends State<ConfirmationServicesPage> {
  bool productsExpanded = true;
  bool servicesExpanded = true;

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
      builder: (context, state) {
        if (state is ServicesSelectedLoaded) {
          // Detectar si solo hay productos seleccionados
          final onlyProducts =
              state.services.isEmpty && state.products.isNotEmpty;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                if (!onlyProducts) ...[
                  CustomTitle(
                    title: texts.requested_date,
                    description: formatDateTime(state.dateSelected),
                  ),
                  const SizedBox(height: 16),
                  CustomTitle(
                    title: texts.requested_schedule,
                    description: state.timeSelected ?? '-',
                  ),
                  const SizedBox(height: 16),
                  CustomTitle(
                    title: texts.approximate_value,
                    description: state.getSummedPriceRange(),
                  ),
                  const SizedBox(height: 16),
                ],

                if (onlyProducts) ...[
                  CustomTitle(
                    title: "Valor total",
                    description: state.getSummedPriceRange(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Productos
                if (state.products.isNotEmpty) ...[
                  CustomTitle(
                    title: 'Productos seleccionados (${state.products.length})',
                    isExpanded: productsExpanded,
                    onTap: () {
                      setState(() {
                        productsExpanded = !productsExpanded;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (productsExpanded)
                    ProductsSelectedListWidget(
                      products: state.products,
                      onQuantityChanged: (product, qty) {
                        context.read<ServicesSelectedBloc>().add(
                              UpdateProductQuantityEvent(
                                product: product,
                                newQuantity: qty,
                              ),
                            );
                      },
                    ),
                  const SizedBox(height: 16),
                ],

                // Servicios
                if (!onlyProducts && state.services.isNotEmpty) ...[
                  CustomTitle(
                    title: 'Servicios seleccionados (${state.services.length})',
                    isExpanded: servicesExpanded,
                    onTap: () {
                      setState(() {
                        servicesExpanded = !servicesExpanded;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (servicesExpanded) ListServicesSelectedWidget(),
                ],
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
