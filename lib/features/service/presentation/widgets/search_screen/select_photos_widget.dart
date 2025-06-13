import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPhotosWidget extends StatelessWidget {
  final QuestionEntity question;
  const SelectPhotosWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 8),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: question.choices
                .map((choiceData) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                        onTap: () async {
                          context.read<ServiceFormBloc>().add(
                              AnswerQuestionEvent(
                                  questionId: question.id,
                                  answer: choiceData['option']));
                        },
                        child: Column(children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              clipBehavior: Clip.hardEdge,
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: question.answer == choiceData['option']
                                      ? Color(0xFFF44565)
                                      : Colors.white),
                              child: Column(children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CustomCachedNetworkImage(
                                            imageUrl: Environment.apiUrl +
                                                choiceData['image']))),
                                const SizedBox(height: 8),
                                Text(choiceData['option'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: question.answer ==
                                                    choiceData['option']
                                                ? Colors.white
                                                : Colors.black))
                              ]))
                        ]))))
                .toList()));
  }
}
