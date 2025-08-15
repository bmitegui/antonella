import 'package:antonella/features/product/presentation/products_info_widget.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_time_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/tab_section_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductsTabSection extends StatelessWidget {
  const ProductsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
      builder: (context, state) {
        int initialPage = 0;

        if (state is ServicesSelectedLoaded) {
          // Si no hay servicios pero sí hay productos, ir directo a confirmación
          if (state.services.isEmpty && state.products.isNotEmpty) {
            initialPage = 3; // índice de ConfirmationServicesPage
          }
        }
        return TabSectionPageView(
          pages: [
            ProductsInfoWidget(),
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
        );
      },
    );
  }
}
