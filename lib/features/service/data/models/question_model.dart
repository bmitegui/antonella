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
    return QuestionModel(
        id: json['id'],
        title: json['title'],
        inputType: stringToInputType(json['input_type']),
        choiceType: stringTocChoiceType(json['choice_type']),
        choices: json['choices'],
        answer: null);
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

ChoiceType? stringTocChoiceType(String? choiceType) {
  return choiceType != null
      ? choiceType == 'IMAGE'
          ? ChoiceType.image
          : ChoiceType.text
      : null;
}
