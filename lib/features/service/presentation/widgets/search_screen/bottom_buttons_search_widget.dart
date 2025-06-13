import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomButtonsSearchScreen extends StatelessWidget {
  final int currentPage;
  final Function() nextPage;
  final Function() previousPage;

  const BottomButtonsSearchScreen(
      {super.key,
      required this.currentPage,
      required this.nextPage,
      required this.previousPage});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 6.9;
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        if (state.services.isNotEmpty) {
          if (currentPage < 3) {
            return Container(
                width: double.infinity,
                height: height,
                color: Color(0xFFF44565),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: nextPage,
                          icon: Row(children: [
                            Text(
                                'Seleccionados(${state.services.length})',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white)
                          ]))
                    ]));
          } else {
            return Container();
          }
        } else {
          return const SizedBox.shrink();
        }

        // return Row(children: [
        //   if (previousPage != null)
        //     CustomIconButton(iconData: Icons.arrow_back, onTap: previousPage),
        //   if (previousPage != null) const SizedBox(width: 16),
        //   if (state.listServicesSelected.isNotEmpty)
        //      CustomIconButton(
        //         iconData: Icons.message, color: Colors.green, onTap: () async => await showModalBottomSheet<List>(
        //                 scrollControlDisabledMaxHeightRatio: 1,
        //                 isScrollControlled: true,
        //                 backgroundColor: Colors.white,
        //                 context: context,
        //                 builder: (BuildContext context) {
        //                   return const ChatsWidget();
        //                 })),
        //   const Spacer(),
        //   const SizedBox(width: 8),
        //   if (nextPage != null)
        //     TextButton(
        //         onPressed: state.listServicesSelected.isNotEmpty
        //             ? () async => await showModalBottomSheet<List>(
        //                 scrollControlDisabledMaxHeightRatio: 1,
        //                 isScrollControlled: true,
        //                 backgroundColor: Colors.white,
        //                 context: context,
        //                 builder: (BuildContext context) {
        //                   return const ServicesSelectedWidget();
        //                 })
        //             : null,
        //         child: Text(
        //             'Seleccionados: (${state.listServicesSelected.length})',
        //             style: Theme.of(context).textTheme.bodyMedium)),
        //   if (nextPage == null)
        //     SizedBox(
        //         width: MediaQuery.of(context).size.width / 2,
        //         child: ElevatedButton(
        //             onPressed: () {
        //               sl<ServicesSelectedBloc>()
        //                   .add(ClearServicesSelectedEvent());
        //               showTopSnackBar(
        //                   Overlay.of(context),
        //                   const CustomSnackBar.success(
        //                       message: 'Solicitud enviada'));
        //               onSend!();
        //             },
        //             child: const Text('Enviar petición'))),
        //   if (nextPage != null) const SizedBox(width: 8),
        //   if (nextPage != null && state.listServicesSelected.isNotEmpty)
        //     CustomIconButton(iconData: Icons.arrow_forward, onTap: nextPage)
        // ]);
      }
      return const SizedBox.shrink();
    });
  }
}
