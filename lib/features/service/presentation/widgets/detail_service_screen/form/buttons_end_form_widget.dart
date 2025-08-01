import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ButtonsEndFormWidget extends StatelessWidget {
  final bool isDescription;
  const ButtonsEndFormWidget({super.key, required this.isDescription});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, stateServiceForm) {
      return (stateServiceForm is ServiceFormLoaded)
          ? BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
              builder: (context, state) {
              if (state is ServicesSelectedLoaded) {
                final index = state.services.indexWhere(
                    (service) => service.id == stateServiceForm.service.id);
                final isSelected = index != -1;

                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (isSelected)
                        CustomElevatedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 48, vertical: 12),
                            onPressed: () async => await showWarningDialog(
                                context: context,
                                title: texts.delete_service,
                                message: texts.sure_delete_service,
                                textOnAccept: texts.eliminate,
                                onAccept: () {
                                  context.read<ServicesSelectedBloc>().add(
                                      DeleteServiceEvent(
                                          service: stateServiceForm.service));
                                  Navigator.pop(context);
                                }),
                            text: texts.eliminate),
                      if (isSelected) const SizedBox(width: 8),
                      CustomElevatedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 48, vertical: 12),
                          onPressed: () {
                            bool isCompleted = stateServiceForm
                                .service.questions
                                .every((serviceForm) =>
                                    serviceForm.answer != null);
                            if (isCompleted) {
                              context.read<ServicesSelectedBloc>().add(
                                  AddServiceEvent(
                                      service: stateServiceForm.service));
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                      message: texts.form_saved));
                              Navigator.pop(context);
                              if (isDescription) {
                                Navigator.pop(context);
                              }
                            } else {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                      message: texts.not_all_fields_completed));
                            }
                          },
                          text: texts.save)
                    ]);
              }
              return const SizedBox.shrink();
            })
          : CircularProgressIndicator();
    });
  }
}
