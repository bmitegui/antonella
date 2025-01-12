import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsSelectWidget extends StatelessWidget {
  final ServiceFormEntity serviceFormEntity;
  const IsSelectWidget({super.key, required this.serviceFormEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? Row(
              children: ['No', '', 'Si']
                  .map((value) => (value.isEmpty)
                      ? const SizedBox(width: 8)
                      : Expanded(
                          child: value == serviceFormEntity.answer
                              ? ElevatedButton(
                                  onPressed: null, child: Text(value))
                              : FilledButton(
                                  onPressed: () {
                                    context.read<ServiceFormBloc>().add(
                                        UpdateAnswerEvent(
                                            id: serviceFormEntity.id,
                                            answer: value,
                                            listServiceForms:
                                                state.listServiceForms));
                                  },
                                  child: Text(value))))
                  .toList())
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
