import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/appointment_info_screen.dart';
import 'package:antonella/core/widgets/banner_widget.dart';
import 'package:flutter/material.dart';

class InfoAppointmentContainer extends StatelessWidget {
  final AppointmentEntity appointmentEntity;
  const InfoAppointmentContainer({super.key, required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateWithSlideTransition(
          context, AppointmentInfoScreen(appointmentEntity: appointmentEntity)),
      child: Container(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(style: BorderStyle.solid, color: Colors.white),
              color: Colors.white),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              BannerWidget(
                  child: CustomLocalSvgImage(
                      assetPath: imagesServiceCategory[
                          appointmentEntity.serviceEntity.type]!)),
              const SizedBox(width: 16),
              Text(
                  getCategoryText(
                      context: context,
                      serviceCategory: appointmentEntity.serviceEntity.type),
                  style: Theme.of(context).textTheme.titleMedium),
              Spacer(),
              Icon(Icons.arrow_forward_ios)
            ]),
            SizedBox(height: 16),
            Row(children: [
              SizedBox(width: 25),
              Icon(Icons.attach_money),
              SizedBox(width: 20),
              Text(
                  '\$${appointmentEntity.basePrice?.toStringAsFixed(2) ?? '0.00'}')
            ]),
            SizedBox(height: 8),
            Row(children: [
              SizedBox(width: 25),
              Icon(Icons.calendar_month),
              SizedBox(width: 20),
              Text('${appointmentEntity.day} - ${appointmentEntity.startTime}')
            ]),
            Divider(),
            Row(children: [
              SizedBox(width: 25),
              Icon(Icons.person),
              SizedBox(width: 20),
              Text(appointmentEntity.userEntity!.name)
            ]),
            SizedBox(height: 10),
            Row(children: [
              SizedBox(width: 25),
              Icon(Icons.email),
              SizedBox(width: 20),
              Text(appointmentEntity.userEntity!.email)
            ])
          ])),
    );
  }
}
