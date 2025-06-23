import 'package:antonella/core/widgets/custom_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_filter_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/services_info_widget.dart';
import 'package:flutter/material.dart';

class SelectServicesPage extends StatelessWidget {
  const SelectServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSearchWidget(),
          const SizedBox(height: 16),
          const ServicesFilterWidget(),
          const SizedBox(height: 16),
          Expanded(child: ServicesInfoWidget()),
        ]);
  }
}
