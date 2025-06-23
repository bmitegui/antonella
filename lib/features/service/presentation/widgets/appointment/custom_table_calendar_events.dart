import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/custom_table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTableCalendarEvents extends StatelessWidget {
  const CustomTableCalendarEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state is OrdersLoaded) {
        final allAppointments = state.orders
            .expand((order) => order.appointments.map((appointment) =>
                appointment.copyWith(userEntity: order.userEntity)))
            .toList();

        return CustomTableCalendar(eventLoader: (day) {
          return allAppointments.where((appointment) {
            final appointmentDate = DateTime.parse(appointment.day);
            return appointmentDate.year == day.year &&
                appointmentDate.month == day.month &&
                appointmentDate.day == day.day;
          }).toList();
        });
      } else if (state is OrdersError) {
        return Text(state.message);
      }

      return const Center(child: CircularProgressIndicator());
    });
  }
}
