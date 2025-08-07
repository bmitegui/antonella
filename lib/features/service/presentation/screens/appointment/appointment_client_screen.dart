import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/agenda_tab_bar.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/custom_table_calendar_events.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/list_orders_not_confirmed.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/list_orders_to_confirm.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class AppointmentClientScreen extends StatefulWidget {
  const AppointmentClientScreen({super.key});

  @override
  State<AppointmentClientScreen> createState() =>
      _AppointmentClientScreenState();
}

class _AppointmentClientScreenState extends State<AppointmentClientScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _calendarRefreshKey = GlobalKey<RefreshIndicatorState>();
  final _toConfirmRefreshKey = GlobalKey<RefreshIndicatorState>();
  final _notConfirmedRefreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
     _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshCurrentTab() async {
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
    }
  }


  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        text: texts.agenda,
        body: Column(children: [
          GestureDetector(
            onDoubleTap: () {
              switch (_tabController.index) {
                case 0:
                  _calendarRefreshKey.currentState?.show();
                  break;
                case 1:
                  _toConfirmRefreshKey.currentState?.show();
                  break;
                case 2:
                  _notConfirmedRefreshKey.currentState?.show();
                  break;
              }
            },
            child: AgendaTabBar(controller: _tabController),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            RefreshIndicator(
                key: _calendarRefreshKey,
                onRefresh: _refreshCurrentTab,
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: const CustomTableCalendarEvents())),
            Expanded(
                child: RefreshIndicator(
                    key: _toConfirmRefreshKey,
                    onRefresh: _refreshCurrentTab,
                    child: ListOrdersToConfirm())),
            Expanded(
              child: RefreshIndicator(
                  key: _notConfirmedRefreshKey,
                  onRefresh: _refreshCurrentTab,
                  child: ListOrdersNotConfirmed()),
            )
          ]))
        ]));
  }
}
