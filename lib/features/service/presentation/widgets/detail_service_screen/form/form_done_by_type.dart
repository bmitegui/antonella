import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/question_entity.dart';
import 'package:flutter/material.dart';

class FormDoneByType extends StatelessWidget {
  final QuestionEntity question;
  final String indexForm;
  const FormDoneByType(
      {super.key, required this.question, required this.indexForm});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(children: [
          CustomTitle(title: question.title, index: indexForm),
          const SizedBox(height: 16),
          (question.inputType == InputType.image)
              ? ImagesScrollview(
                  height: 150,
                  isSVG: false,
                  isUrl: false,
                  images: question.answer)
              : (question.inputType == InputType.choice &&
                      question.choiceType == ChoiceType.image)
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Text(question.answer))
                  : (question.inputType == InputType.choice &&
                          question.choiceType == ChoiceType.text)
                      ? Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: Text(question.answer))
                      : (question.inputType == InputType.text)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48),
                              child: Text(question.answer))
                          : const SizedBox.shrink()
        ]));
  }
}
