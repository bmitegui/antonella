import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/buttons_end_form_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_by_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServiceFormsWidget extends StatelessWidget {
  const ListServiceFormsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? Column(children: [
              ...state.service.questions.asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value;
                return FormByType(
                    question: question, indexForm: (index + 1).toString());
              }),
              ButtonsEndFormWidget()
            ])
          : CircularProgressIndicator();
    });
  }
}
