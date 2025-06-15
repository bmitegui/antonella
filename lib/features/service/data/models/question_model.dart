import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel(
      {required super.id,
      required super.title,
      required super.inputType,
      super.choiceType,
      super.choices,
      super.answer});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final questionModel = QuestionModel(
        id: json['id'],
        title: capitalize(json['title']),
        inputType: stringToInputType(json['input_type']),
        choiceType: stringToChoiceType(json['choice_type']),
        choices: json['choices'],
        answer: null);
    return questionModel;
  }
}

InputType stringToInputType(String inputType) {
  return inputType == 'CHOICE'
      ? InputType.choice
      : inputType == 'IMAGE'
          ? InputType.image
          : InputType.text;
}

String choiceTypeToString(InputType inputType) {
  return inputType.name;
}

ChoiceType? stringToChoiceType(String? choiceType) {
  return choiceType != null
      ? choiceType == 'IMAGE'
          ? ChoiceType.image
          : ChoiceType.text
      : null;
}
