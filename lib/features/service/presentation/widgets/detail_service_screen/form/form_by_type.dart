import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/question_entity.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/input_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/is_select_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/list_photos_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/select_photos_widget.dart';
import 'package:flutter/material.dart';

class FormByType extends StatelessWidget {
  final QuestionEntity question;
  final String indexForm;
  const FormByType(
      {super.key, required this.question, required this.indexForm});
  @override
  Widget build(BuildContext context) {
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
                          question.choiceType == ChoiceType.text)
                      ? IsSelectWidget(question: question)
                      : (question.inputType == InputType.text)
                          ? InputWidget(question: question)
                          : const SizedBox.shrink()
        ]));
  }
}
