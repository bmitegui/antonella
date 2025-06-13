import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/send_request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomButtonsSearchScreen extends StatelessWidget {
  final int currentPage;
  final Function() nextPage;
  final Function() previousPage;
  final Function() sendRequest;

  const BottomButtonsSearchScreen(
      {super.key,
      required this.currentPage,
      required this.nextPage,
      required this.previousPage, required this.sendRequest});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 6.3;
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
                            Text('Seleccionados(${state.services.length})',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white)
                          ]))
                    ]));
          } else {
            return SendRequestButton(sendRequest: sendRequest);
          }
        } else {
          return const SizedBox.shrink();
        }
      }
      return const SizedBox.shrink();
    });
  }
}
