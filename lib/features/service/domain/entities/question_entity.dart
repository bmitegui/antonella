import 'package:equatable/equatable.dart';

enum InputType { choice, image, text }

enum ChoiceType { image, text }

class QuestionEntity extends Equatable {
  final String id;
  final String title;
  final InputType inputType;
  final ChoiceType? choiceType;
  final dynamic choices;
  final dynamic answer;

  const QuestionEntity(
      {required this.id,
      required this.title,
      required this.inputType,
      required this.choiceType,
      required this.choices,
      required this.answer});

  @override
  List<Object?> get props => [id];

  QuestionEntity copyWith({
    String? id,
    String? title,
    InputType? inputType,
    ChoiceType? choiceType,
    dynamic choices,
    dynamic answer,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      inputType: inputType ?? this.inputType,
      choiceType: choiceType ?? this.choiceType,
      choices: choices ?? this.choices,
      answer: answer ?? this.answer,
    );
  }
}
