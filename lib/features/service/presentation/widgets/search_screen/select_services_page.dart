import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_filter_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectServicesPage extends StatelessWidget {
  final Function() nextPage;
  const SelectServicesPage({super.key, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      return Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            const ProgressSearchWidget(page: 1),
            const SizedBox(height: 16),
            const ServicesFilterWidget(),
            const SizedBox(height: 16),
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () async => context
                        .read<ServiceBloc>()
                        .add(GetServicesEvent(filter: null)),
                    child: const SingleChildScrollView(
                        child: ServicesInfoWidget()))),
            const SizedBox(height: 16),
            BottomButtonsSearchScreen(nextPage: nextPage)
          ]));
    });
  }
}
