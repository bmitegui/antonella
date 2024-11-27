import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:antonella/features/service/presentation/widgets/services_selected_widget.dart';
import 'package:flutter/material.dart';

class BottomButtonsSearchScreen extends StatelessWidget {
  final List<String> servicesSelected;
  final Function()? nextPage;
  final Function()? previousPage;
  final bool enableChat;

  const BottomButtonsSearchScreen(
      {super.key,
      required this.servicesSelected,
      this.nextPage,
      this.previousPage,
      this.enableChat = false});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (previousPage != null)
        CustomIconButton(iconData: Icons.arrow_back, onTap: previousPage),
      if (previousPage != null) const SizedBox(width: 16),
      if (enableChat)
        const CustomIconButton(iconData: Icons.message, color: Colors.green),
      const Spacer(),
      const SizedBox(width: 8),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ServicesSelectedWidget(
                      servicesSelected: servicesSelected);
                });
          },
          child: Text('Seleccionados: (${servicesSelected.length})',
              style: Theme.of(context).textTheme.bodyMedium)),
      if (nextPage != null) const SizedBox(width: 8),
      if (nextPage != null)
        CustomIconButton(iconData: Icons.arrow_forward, onTap: nextPage)
    ]);
  }
}
