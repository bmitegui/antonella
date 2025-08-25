import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/list_chats_widget.dart';
import 'package:flutter/material.dart';

class ListEmployees extends StatelessWidget {
  const ListEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: 'Empleados',
        body: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Selecciona el empleado que prefieras',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54)),
          const SizedBox(height: 16),
          const Expanded(child: ListChatsWidget())
        ])));
  }
}
