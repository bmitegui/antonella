import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/custom_table_calendar_events.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class AppointmentEmployeeScreen extends StatelessWidget {
  const AppointmentEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        text: texts.agenda,
        body: RefreshIndicator(
            onRefresh: () async {
              final userState = sl<UserBloc>().state;
              if (userState is UserAuthenticated) {
                sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
              }
            },
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: const CustomTableCalendarEvents())));
  }
}
