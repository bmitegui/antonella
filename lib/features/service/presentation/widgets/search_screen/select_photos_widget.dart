import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
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
              padding: EdgeInsets.only(bottom: 8),
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
                                        answer: entry.key,
                                        listServiceForms:
                                            state.listServiceForms));
                              },
                              child: Column(children: [
                                Container(
                                    padding: EdgeInsets.all(8),
                                    clipBehavior: Clip.hardEdge,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: serviceFormEntity.answer ==
                                                entry.key
                                            ? Color(0xFFF44565)
                                            : Colors.white),
                                    child: Column(children: [
                                      Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: CustomCachedNetworkImage(
                                                imageUrl: entry.value)
                                          )),
                                      const SizedBox(height: 8),
                                      Text(entry.key,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: serviceFormEntity
                                                              .answer ==
                                                          entry.key
                                                      ? Colors.white
                                                      : Colors.black))
                                    ])),
                              ]))))
                      .toList()))
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
