import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsSelectWidget extends StatelessWidget {
  final QuestionEntity question;
  const IsSelectWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: (question.choices as List)
                  .map((value) => value.isEmpty
                      ? SizedBox()
                      : CustomElevatedButton(
                          backgroundColor: value != question.answer
                              ? Color(0xFFFAE2E1)
                              : Color(0xFFF44565),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          onPressed: () {
                            context.read<ServiceFormBloc>().add(
                                AnswerQuestionEvent(
                                    questionId: question.id, answer: value));
                          },
                          text: value))
                  .toList())
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
