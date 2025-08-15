import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_time_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/tab_section_page_view.dart';
import 'package:flutter/material.dart';

class ServicesTabSection extends StatelessWidget {
  const ServicesTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TabSectionPageView(
      pages: [
        SelectServicesPage(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectDatePage(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectTimePage(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConfirmationServicesPage(),
        ),
      ],
      titleText: null,
    );
  }
}
