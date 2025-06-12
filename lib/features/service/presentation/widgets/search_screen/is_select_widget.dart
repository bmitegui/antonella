import 'package:antonella/core/widgets/custom_elevated_button.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['', 'Sí', 'No', '']
                  .map((value) => value.isEmpty
                      ? SizedBox()
                      : CustomElevatedButton(
                          backgroundColor: value != serviceFormEntity.answer
                              ? Color(0xFFFAE2E1)
                              : Color(0xFFF44565),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          onPressed: () {
                            context.read<ServiceFormBloc>().add(
                                UpdateAnswerEvent(
                                    id: serviceFormEntity.id,
                                    answer: value,
                                    listServiceForms: state.listServiceForms));
                          },
                          text: value))
                  .toList())
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
