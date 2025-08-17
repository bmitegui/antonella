import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/appointment_info_screen.dart';
import 'package:antonella/core/widgets/banner_widget.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/employees_rows_info_to_client.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/progress_status_label.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/pending_appointment_modal.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class InfoAppointmentContainer extends StatelessWidget {
  final bool isAgendaScreen;
  final OrderEntity orderEntity;
  final AppointmentEntity appointmentEntity;
  const InfoAppointmentContainer(
      {super.key,
      required this.isAgendaScreen,
      required this.orderEntity,
      required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    bool isClient = false;
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      isClient = userState.user.rol == Rol.cliente;
    }
    return GestureDetector(
        onTap: () async =>
            (!isClient && appointmentEntity.status == ProgressStatus.pendiente)
                ? await showModalBottomSheet<List>(
                    scrollControlDisabledMaxHeightRatio: 1,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return PendingAppointmentModal(
                          isAgendaScreen: isAgendaScreen,
                          orderEntity: orderEntity,
                          appointmentEntity: appointmentEntity);
                    })
                : navigateWithSlideTransition(
                    context,
                    AppointmentInfoScreen(
                        isAgendaScreen: isAgendaScreen,
                        orderEntity: orderEntity,
                        appointmentEntity: appointmentEntity)),
        child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.white),
                color: Colors.white),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                BannerWidget(
                    child: CustomLocalImage(
                        assetPath: imagesServiceCategory[
                            appointmentEntity.serviceEntity.type]!)),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      getCategoryText(
                          context: context,
                          serviceCategory:
                              appointmentEntity.serviceEntity.type),
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  Text(appointmentEntity.serviceEntity.name)
                ]),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ]),
              SizedBox(height: 16),
              Row(children: [
                Icon(Icons.attach_money),
                SizedBox(width: 6),
                Text(
                    '\$${appointmentEntity.basePrice?.toStringAsFixed(2) ?? '0.00'}'),
                Spacer(),
                ProgressStatusLabel(status: appointmentEntity.status)
              ]),
              SizedBox(height: 8),
              Row(children: [
                Icon(Icons.calendar_month),
                SizedBox(width: 6),
                Text(
                    '${appointmentEntity.day} - ${appointmentEntity.startTime}')
              ]),
              SizedBox(height: 16),
              EmployeesRowsInfoToClient(employees: appointmentEntity.employees)
            ])));
  }
}
