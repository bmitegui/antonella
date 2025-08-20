import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/start_appointment/start_appointment_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StartAppoinmentButton extends StatelessWidget {
  final bool isAgendaScreen;
  final OrderEntity orderEntity;
  final AppointmentEntity appointmentEntity;
  const StartAppoinmentButton(
      {super.key,
      required this.isAgendaScreen,
      required this.orderEntity,
      required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocConsumer<StartAppointmentBloc, StartAppointmentState>(
        listener: (context, state) {
      if (state is StartAppointmentLoaded) {
        final userState = sl<UserBloc>().state;
        if (userState is UserAuthenticated) {
          sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
        }
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.success(message: texts.appointment_started));
        if (isAgendaScreen) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      } else if (state is StartAppointmentError) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
                message: mapFailureToMessage(
                    context: context, failure: state.failure)));
      }
    }, builder: (context, state) {
      return (state is StartAppointmentLoading)
          ? Center(child: CircularProgressIndicator())
          : FilledButton(
              onPressed: () {
                final appointmentDate = DateTime.parse(appointmentEntity.day);
                final today = DateTime.now();

                final isSameDay = appointmentDate.year == today.year &&
                    appointmentDate.month == today.month &&
                    appointmentDate.day == today.day;

                if (!isSameDay) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                        message:
                            "Solo puedes iniciar la cita el día agendado."),
                  );
                  return;
                }
                context.read<StartAppointmentBloc>().add(
                      EmpezarCitaEvent(
                        orderId: orderEntity.id,
                        appointmentId: appointmentEntity.id,
                      ),
                    );
              },
              child: Text(texts.start_appointment),
            );
    });
  }
}
