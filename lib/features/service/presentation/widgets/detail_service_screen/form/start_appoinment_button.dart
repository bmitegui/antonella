import 'package:antonella/core/injection/injection_container.dart';
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
    return BlocConsumer<StartAppointmentBloc, StartAppointmentState>(
        listener: (context, state) {
      if (state is StartAppointmentLoaded) {
        final userState = sl<UserBloc>().state;
        if (userState is UserAuthenticated) {
          sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
        }
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.success(message: 'Cita empezada'));
        if (isAgendaScreen) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      }
    }, builder: (context, state) {
      return (state is StartAppointmentLoading)
          ? CircularProgressIndicator()
          : FilledButton(
              onPressed: () => context.read<StartAppointmentBloc>().add(
                  EmpezarCitaEvent(
                      orderId: orderEntity.id,
                      appointmentId: appointmentEntity.id)),
              child: Text("Empezar cita"));
    });
  }
}
