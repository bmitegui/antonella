import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/service/presentation/bloc/comment/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RateService extends StatefulWidget {
  final String serviceId;
  const RateService({super.key, required this.serviceId});

  @override
  State<RateService> createState() => _RateServiceState();
}

class _RateServiceState extends State<RateService> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Calificar servicio:",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          FilledButton(
            onPressed: () async {
              await showModalBottomSheet<List>(
                scrollControlDisabledMaxHeightRatio: 1,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: double.infinity,
                    child: CustomModalBottomSheetWidget(
                      closeAction: false,
                      title: "Califica el servicio",
                      body: Padding(
                        padding: const EdgeInsets.all(16),
                        child: StatefulBuilder(
                          builder: (context, setModalState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      onPressed: () {
                                        setModalState(() {
                                          // <- usar setModalState
                                          _rating = index + 1;
                                        });
                                      },
                                      icon: Icon(
                                        index < _rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 32,
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 16),
                                CustomTextFormFieldWidget(
                                  fillColor: Color(0xFFFAE2E1),
                                  textEditingController: _commentController,
                                  maxLines: 3,
                                  hintText: "Escribe un comentario",
                                ),
                                const SizedBox(height: 16),
                                BlocConsumer<CommentBloc, CommentState>(
                                  builder: (context, state) {
                                    return FilledButton(
                                      onPressed: () {
                                        context.read<CommentBloc>().add(
                                            AddServiceCommentEvent(
                                                serviceId: widget.serviceId,
                                                comment: _commentController.text
                                                    .trim(),
                                                stars: _rating));
                                      },
                                      child: const Text("Calificar"),
                                    );
                                  },
                                  listener: (BuildContext context,
                                      CommentState state) {
                                    if (state is CommentsLoaded) {
                                      showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.success(
                                              message: "Comentario enviado"));
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.amber),
            ),
            child: const Text('Calificar'),
          ),
        ],
      )
    ]);
  }
}
