import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SendRequestButton extends StatelessWidget {
  final Function() sendRequest;

  const SendRequestButton({super.key, required this.sendRequest});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height / 6.3;

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, stateServiceSelected) {
      if (stateServiceSelected is ServicesSelectedLoaded) {
        return BlocBuilder<UserBloc, UserState>(builder: (context, stateUser) {
          if (stateUser is UserAuthenticated) {
            return BlocConsumer<SendRequestBloc, SendRequestState>(
                listener: (context, stateSendRequest) {
              if (stateSendRequest is SendRequestError) {
                showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                        message: mapFailureToMessage(
                            context: context,
                            failure: stateSendRequest.failure)));
              } else {
                showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                        maxLines: 3, message: texts.request_sent_succesfully));
                context
                    .read<ServicesSelectedBloc>()
                    .add(ClearServicesSelectedEvent());
                final userState = sl<UserBloc>().state;
                if (userState is UserAuthenticated) {
                  context
                      .read<OrdersBloc>()
                      .add(GetOrdersEvent(id: userState.user.id));
                }

                sendRequest();
              }
            }, builder: (context, stateSendRequest) {
              if (stateSendRequest is SendRequestLoading) {
                return SizedBox(
                    width: double.infinity,
                    height: height,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircularProgressIndicator(),
                          const SizedBox(width: 32)
                        ]));
              } else {
                return SizedBox(
                    width: double.infinity,
                    height: height,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                              onPressed: () async {
                                if (stateServiceSelected.dateSelected == null) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                          message:
                                              "Por favor elija una fecha"));
                                } else if (stateServiceSelected.timeSelected ==
                                    null) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                          message:
                                              "Por favor elija un horario"));
                                } else if (stateServiceSelected.employeeIds ==
                                        null ||
                                    stateServiceSelected.employeeIds!.length !=
                                        stateServiceSelected.services.length) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                          message:
                                              "Por favor elija un especialista para cada servicio escogido"));
                                } else {
                                  context.read<SendRequestBloc>().add(
                                      EnviarPeticionEvent(
                                          clientId: stateUser.user.id,
                                          day: formatDateTime(
                                              stateServiceSelected
                                                  .dateSelected),
                                          start: stateServiceSelected
                                              .timeSelected!,
                                          employeeIds:
                                              stateServiceSelected.employeeIds!,
                                          services:
                                              stateServiceSelected.services));
                                }
                              },
                              text: texts.submit_request)
                        ]));
              }
            });
          } else {
            return const SizedBox.shrink();
          }
        });
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
