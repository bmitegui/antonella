import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/notification_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        text: texts.notifications,
        body: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: BlocConsumer<NotificationsBloc, NotificationsState>(
                listener: (context, state) {
              if (state is NotificationsError) {
                showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                        message: mapFailureToMessage(
                            context: context, failure: state.failure)));
              }
            }, builder: (context, state) {
              return state is NotificationsLoading
                  ? Center(child: CircularProgressIndicator())
                  : state is NotificationsLoaded
                      ? (state.notifications.isNotEmpty)
                          ? NotificationListWidget(
                              notifications: state.notifications)
                          : notificationsEmptyWidget(texts: texts)
                      : SizedBox.shrink();
            })));
  }

  Widget notificationsEmptyWidget({required AppLocalizations texts}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: LottieBuilder.asset("assets/lottie/notification.json")),
          const SizedBox(height: 32),
          Text(texts.no_notifications,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(texts.notification_message),
          const SizedBox(height: 128)
        ]);
  }
}
