import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_appointment_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentWithOrder {
  final OrderEntity order;
  final AppointmentEntity appointment;

  AppointmentWithOrder(this.order, this.appointment);
}

class FilterListAppointment extends StatelessWidget {
  final ProgressStatus? status;
  final String? value;
  const FilterListAppointment(
      {super.key, required this.status, required this.value});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          // Juntar citas con sus órdenes
          List<AppointmentWithOrder> appointmentEntries = state.orders
              .expand((order) =>
                  order.appointments.map((a) => AppointmentWithOrder(order, a)))
              .toList();

          // Filtrar por estado si se ha seleccionado uno
          if (status != null) {
            appointmentEntries = appointmentEntries
                .where((entry) => entry.appointment.status == status)
                .toList();
          }

          if (value != null) {
            if (value == "Nombre") {
              // Ordenar por nombre
              appointmentEntries.sort((a, b) => b.appointment.serviceEntity.name
                  .compareTo(a.appointment.serviceEntity.name));
            } else if (value == "Precio") {
              // Ordenar por precio
              appointmentEntries.sort((a, b) =>
                  b.appointment.basePrice!.compareTo(a.appointment.basePrice!));
            } else {
              // Ordenar por los mas recientes
              appointmentEntries.sort(
                  (a, b) => a.appointment.day.compareTo(b.appointment.day));
            }
          }

          return appointmentEntries.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: appointmentEntries.map((entry) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InfoAppointmentContainer(
                            isAgendaScreen: false,
                            orderEntity: entry.order,
                            appointmentEntity: entry.appointment));
                  }).toList())
              : Center(child: Text('No existen citas disponibles'));
        } else if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
