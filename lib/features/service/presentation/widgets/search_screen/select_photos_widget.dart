// ignore_for_file: deprecated_member_use

import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/service_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPhotosWidget extends StatelessWidget {
  final ServiceFormEntity serviceFormEntity;
  const SelectPhotosWidget({super.key, required this.serviceFormEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: serviceFormEntity.urlPhotos!.entries
                      .map((entry) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                              onTap: () async {
                                context.read<ServiceFormBloc>().add(
                                    UpdateAnswerEvent(
                                        id: serviceFormEntity.id,
                                        answer: entry.value,
                                        listServiceForms:
                                            state.listServiceForms));
                              },
                              child: Column(children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: serviceFormEntity.answer ==
                                                entry.value
                                            ? Colors.green
                                            : Colors.grey.shade50,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: const Offset(0, 2),
                                              blurRadius: 1)
                                        ]),
                                    child: ServiceImageNetwork(
                                        urlImage: entry.value)),
                                const SizedBox(height: 8),
                                Text(entry.key)
                              ]))))
                      .toList()))
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
