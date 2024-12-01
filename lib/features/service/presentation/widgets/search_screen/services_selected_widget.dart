import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_services_selected_widget.dart';
import 'package:flutter/material.dart';

class ServicesSelectedWidget extends StatelessWidget {
  const ServicesSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: 'Servicios seleccionados',
        body: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Revisa y organiza tus los servicios seleccionados fácilmente.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54)),
          const SizedBox(height: 16),
          const Expanded(child: ListServicesSelectedWidget())
        ])));
  }
}
