import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/banner_widget.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/progress_status_label.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/start_appoinment_button.dart';
import 'package:flutter/material.dart';

class PendingAppointmentModal extends StatelessWidget {
  final bool isAgendaScreen;
  final OrderEntity orderEntity;
  final AppointmentEntity appointmentEntity;
  const PendingAppointmentModal(
      {super.key,
      required this.isAgendaScreen,
      required this.orderEntity,
      required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomModalBottomSheetWidget(
        closeAction: false,
        titleWidget: ProgressStatusLabel(status: appointmentEntity.status),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Divider(color: Colors.grey.shade300),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BannerWidget(
                child: CustomLocalSvgImage(
                    assetPath: imagesServiceCategory[
                        appointmentEntity.serviceEntity.type]!)),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(appointmentEntity.serviceEntity.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 8),
                    Text(
                        '\$${appointmentEntity.basePrice?.toStringAsFixed(2) ?? '0.00'}')
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 8),
                    Text(
                        '${appointmentEntity.day} - ${appointmentEntity.startTime}')
                  ])
                ]))
          ]),
          const SizedBox(height: 16),
          Text(appointmentEntity.serviceEntity.subtype,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          Text(appointmentEntity.serviceEntity.description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black54, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xFFFAE2E1),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(children: [
                Row(children: [
                  CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          const AssetImage('assets/img/placeholder_women.png')),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(texts.customer_data,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(orderEntity.userEntity.name)
                      ]))
                ]),
                const SizedBox(height: 16),
                Row(children: [
                  Icon(Icons.email),
                  SizedBox(width: 8),
                  Text(orderEntity.userEntity.email)
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.phone),
                  SizedBox(width: 8),
                  Text(orderEntity.userEntity.phoneNumber)
                ]),
                const SizedBox(height: 16),
                StartAppoinmentButton(
                  isAgendaScreen: isAgendaScreen,
                    orderEntity: orderEntity,
                    appointmentEntity: appointmentEntity)
              ]))
        ]));
  }
}
