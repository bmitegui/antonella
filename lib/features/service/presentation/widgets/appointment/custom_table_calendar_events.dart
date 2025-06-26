import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/custom_table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTableCalendarEvents extends StatelessWidget {
  const CustomTableCalendarEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          final orders = state.orders;

          return CustomTableCalendar(
            eventLoader: (day) {
              return orders.where((order) {
                final isClientConfirmed =
                    order.clientStatus == ClientStatus.confirmado;

                final hasAppointmentThatDay =
                    order.appointments.any((appointment) {
                  final appointmentDate = DateTime.parse(appointment.day);
                  return appointmentDate.year == day.year &&
                      appointmentDate.month == day.month &&
                      appointmentDate.day == day.day;
                });

                return isClientConfirmed && hasAppointmentThatDay;
              }).toList();
            },
          );
        } else if (state is OrdersError) {
          return Text(
            mapFailureToMessage(context: context, failure: state.failure),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
