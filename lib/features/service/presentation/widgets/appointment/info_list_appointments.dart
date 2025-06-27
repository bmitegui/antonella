import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_appointment_container.dart';
import 'package:flutter/material.dart';

class InfoListAppointments extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoListAppointments({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: 'Servicios escogidos',
        body: Expanded(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: orderEntity.appointments
                        .map((appointment) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: InfoAppointmentContainer(
                              isAgendaScreen: true,
                              orderEntity: orderEntity,
                                appointmentEntity: appointment)))
                        .toList()))));
  }
}
