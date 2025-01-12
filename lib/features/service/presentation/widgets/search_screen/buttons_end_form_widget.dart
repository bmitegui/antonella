import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ButtonsEndFormWidget extends StatelessWidget {
  final List<ServiceFormEntity> listServiceForms;
  final ServiceEntity serviceEntity;

  const ButtonsEndFormWidget(
      {super.key, required this.listServiceForms, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return Row(children: [
          if (serviceEntity.isSelected)
            Expanded(
                child: FilledButton(
                    onPressed: () async => await showWarningDialog(
                        context: context,
                        title: 'Eliminar servicio',
                        message:
                            '¿Está seguro que desea eliminar el servicio seleccionado?',
                        textOnAccept: 'Eliminar',
                        onAccept: () {
                          context.read<ServicesSelectedBloc>().add(
                              DeleteServiceSelectedEvent(
                                  serviceEntitySelected: serviceEntity,
                                  listServicesSelected:
                                      state.listServicesSelected,
                                  dateSelected: state.dateSelected,
                                  timeSelected: state.timeSelected));
                          Navigator.pop(context);
                        }),
                    child: const Text('Eliminar'))),
          if (serviceEntity.isSelected) const SizedBox(width: 8),
          Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    bool isCompleted = listServiceForms
                        .every((serviceForm) => serviceForm.answer != null);
                    if (isCompleted) {
                      final serviceSelected = serviceEntity.copyWith(
                          listServiceFormsEntity: listServiceForms);

                      context.read<ServicesSelectedBloc>().add(
                          AddServiceSelectedEvent(
                              serviceEntitySelected: serviceSelected,
                              listServicesSelected: state.listServicesSelected,
                              dateSelected: state.dateSelected,
                              timeSelected: state.timeSelected));
                      showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                              message: 'Formulario guardado'));
                      Navigator.pop(context);
                    } else {
                      showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                              message: 'No ha completado todos los campos'));
                    }
                  },
                  child: const Text('Guardar')))
        ]);
      }
      return const SizedBox.shrink();
    });
  }
}
