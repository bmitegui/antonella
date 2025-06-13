import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ButtonsEndFormWidget extends StatelessWidget {
  const ButtonsEndFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                                title: 'Eliminar servicio',
                                message:
                                    '¿Está seguro que desea eliminar el servicio seleccionado?',
                                textOnAccept: 'Eliminar',
                                onAccept: () {
                                  context.read<ServicesSelectedBloc>().add(
                                      DeleteServiceEvent(
                                          service: stateServiceForm.service));
                                  Navigator.pop(context);
                                }),
                            text: 'Eliminar'),
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
                                  const CustomSnackBar.success(
                                      message: 'Formulario guardado'));
                              Navigator.pop(context);
                            } else {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                      message:
                                          'No ha completado todos los campos'));
                            }
                          },
                          text: 'Guardar')
                    ]);
              }
              return const SizedBox.shrink();
            })
          : CircularProgressIndicator();
    });
  }
}
