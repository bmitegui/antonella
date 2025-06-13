import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/buttons_end_form_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/input_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/is_select_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_photos_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_photos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServiceFormsWidget extends StatelessWidget {
  const ListServiceFormsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? Column(
              children: state.service.questions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final question = entry.value;
                    return buildFormByType(
                        question: question, indexForm: (index + 1).toString());
                  }).toList() +
                  [ButtonsEndFormWidget()])
          : CircularProgressIndicator();
    });
  }

  Widget buildFormByType(
      {required QuestionEntity question, required String indexForm}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(children: [
          CustomTitle(title: question.title, index: indexForm),
          const SizedBox(height: 16),
          (question.inputType == InputType.image)
              ? ListPhotosWidget(question: question)
              : (question.inputType == InputType.choice &&
                      question.choiceType == ChoiceType.image)
                  ? SelectPhotosWidget(question: question)
                  : (question.inputType == InputType.choice &&
                          question.choiceType == ChoiceType.image)
                      ? IsSelectWidget(question: question)
                      : (question.inputType == InputType.text)
                          ? InputWidget(question: question)
                          : const SizedBox.shrink()
        ]));
  }
}
