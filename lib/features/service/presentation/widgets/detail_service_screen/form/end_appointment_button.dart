import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/end_appointment/end_appointment_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EndAppoinmentButton extends StatelessWidget {
  final bool isAgendaScreen;
  final OrderEntity orderEntity;
  final AppointmentEntity appointmentEntity;
  const EndAppoinmentButton(
      {super.key,
      required this.isAgendaScreen,
      required this.orderEntity,
      required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocConsumer<EndAppointmentBloc, EndAppointmentState>(
        listener: (context, state) {
      if (state is EndAppointmentLoaded) {
        final userState = sl<UserBloc>().state;
        if (userState is UserAuthenticated) {
          sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
        }
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.success(message: texts.appointment_ended));
        if (isAgendaScreen) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } else if (state is EndAppointmentError) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
                message: mapFailureToMessage(
                    context: context, failure: state.failure)));
      }
    }, builder: (context, state) {
      return (state is EndAppointmentLoading)
          ? Center(child: CircularProgressIndicator())
          : FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Terminar Cita"),
                      content: const Text("Deseas terminar la cita"),
                      backgroundColor: Colors.white,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cerrar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform an action
                            context.read<EndAppointmentBloc>().add(
                              TerminarCitaEvent(
                                  orderId: orderEntity.id,
                                  appointmentId: appointmentEntity.id));
                          },
                          child: const Text('Aceptar'),
                        ),
                      ],
                    );
                  }
                );
                
              },
              child: Text(texts.end_appointment));
    });
  }
}
