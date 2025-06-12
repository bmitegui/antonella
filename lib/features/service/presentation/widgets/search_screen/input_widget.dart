import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputWidget extends StatefulWidget {
  final ServiceFormEntity serviceFormEntity;

  const InputWidget({super.key, required this.serviceFormEntity});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.serviceFormEntity.answer != null) {
      _textEditingController =
          TextEditingController(text: widget.serviceFormEntity.answer);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? CustomTextFormFieldWidget(
              maxLines: 5,
              fillColor: Color(0xFFFAE2E1),
              textEditingController: _textEditingController,
              onChanged: (value) {
                context.read<ServiceFormBloc>().add(UpdateAnswerEvent(
                    id: widget.serviceFormEntity.id,
                    answer: (value.trim().isEmpty) ? null : value,
                    listServiceForms: state.listServiceForms));
              },
              hintText: '')
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
