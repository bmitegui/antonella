import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/core/widgets/banner_widget.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/form_done/form_done_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/progress_status_label.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/end_appointment_button.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_done.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class AppointmentInfoScreen extends StatelessWidget {
  final bool isAgendaScreen;
  final OrderEntity orderEntity;
  final AppointmentEntity appointmentEntity;
  const AppointmentInfoScreen(
      {super.key,
      required this.isAgendaScreen,
      required this.orderEntity,
      required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    bool isClient = false;
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      isClient = userState.user.rol == Rol.cliente;
    }
    final bool canFinishAppointment =
        (!isClient && appointmentEntity.status == ProgressStatus.enProgreso);
    return CustomScaffold(
        bottomNavigationBar: canFinishAppointment
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: EndAppoinmentButton(
                    isAgendaScreen: isAgendaScreen,
                    orderEntity: orderEntity,
                    appointmentEntity: appointmentEntity))
            : null,
        leading: ArrowBack(),
        text: 'Cita',
        body: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.white),
                color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  Text(appointmentEntity.serviceEntity.subtype)
                ]),
                Spacer(),
                ProgressStatusLabel(status: appointmentEntity.status)
              ]),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              CustomTitle(title: texts.about),
              const SizedBox(height: 16),
              Text(appointmentEntity.serviceEntity.name),
              Text(appointmentEntity.serviceEntity.description),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              CustomTitle(title: texts.date, description: appointmentEntity.day),
              const SizedBox(height: 16),
              CustomTitle(
                  title: texts.schedule, description: appointmentEntity.startTime),
              const SizedBox(height: 16),
              CustomTitle(
                  title: texts.value,
                  description:
                      '\$${appointmentEntity.basePrice?.toStringAsFixed(2) ?? '0.00'}'),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              CustomTitle(title: texts.form_done),
              const SizedBox(height: 16),
              FilledButton(
                  onPressed: () async {
                    sl<FormDoneBloc>().add(GetFormDoneEvent(
                        clientId: orderEntity.clientId,
                        serviceItemId: appointmentEntity.id));

                    await showModalBottomSheet<List>(
                        scrollControlDisabledMaxHeightRatio: 1,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return FormDone();
                        });
                  },
                  child: Text(texts.view_form))
            ])));
  }
}
