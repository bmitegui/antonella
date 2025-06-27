import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/presentation/bloc/form_done/form_done_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_done_by_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServiceFormsDone extends StatelessWidget {
  const ListServiceFormsDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormDoneBloc, FormDoneState>(builder: (context, state) {
      return (state is FormDoneLoaded)
          ? Column(
              children: state.questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;
              return FormDoneByType(
                  question: question, indexForm: (index + 1).toString());
            }).toList())
          : (state is FormDoneError)
              ? Text(
                  mapFailureToMessage(context: context, failure: state.failure))
              : CircularProgressIndicator();
    });
  }
}
