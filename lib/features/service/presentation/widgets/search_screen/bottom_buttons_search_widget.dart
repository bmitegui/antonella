import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/services_selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomButtonsSearchScreen extends StatelessWidget {
  final Function()? nextPage;
  final Function()? previousPage;

  const BottomButtonsSearchScreen(
      {super.key, this.nextPage, this.previousPage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return Row(children: [
          if (previousPage != null)
            CustomIconButton(iconData: Icons.arrow_back, onTap: previousPage),
          if (previousPage != null) const SizedBox(width: 16),
          if (state.listServicesSelected.isNotEmpty)
            const CustomIconButton(
                iconData: Icons.message, color: Colors.green),
          const Spacer(),
          const SizedBox(width: 8),
          if (nextPage != null)
            TextButton(
                onPressed: state.listServicesSelected.isNotEmpty
                    ? () async => await showModalBottomSheet<List>(
                        scrollControlDisabledMaxHeightRatio: 1,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return const ServicesSelectedWidget();
                        })
                    : null,
                child: Text(
                    'Seleccionados: (${state.listServicesSelected.length})',
                    style: Theme.of(context).textTheme.bodyMedium)),
          if (nextPage == null)
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Enviar petición'))),
          if (nextPage != null) const SizedBox(width: 8),
          if (nextPage != null && state.listServicesSelected.isNotEmpty)
            CustomIconButton(iconData: Icons.arrow_forward, onTap: nextPage)
        ]);
      }
      return const SizedBox.shrink();
    });
  }
}
