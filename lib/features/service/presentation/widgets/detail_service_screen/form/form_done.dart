import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/list_service_forms_done.dart';
import 'package:flutter/material.dart';

class FormDone extends StatelessWidget {
  const FormDone({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: texts.form_loaded,
        body: Expanded(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ListServiceFormsDone()]))));
  }
}
