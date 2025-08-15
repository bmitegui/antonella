import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/history_labels.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/history_grid_view.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({super.key});

  @override
  State<HomeScreenEmployee> createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
  final List<String> labels = ['Semanal', 'Mensual', 'Anual'];
  String selectedLabel = 'Semanal';

  Key historyLabelsKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDefaultData();
    });
  }

  void _loadDefaultData() {
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      final dates = obtenerRangoFechas('SEMANAL');
      sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
        employeeId: userState.user.id,
        startDate: dates['startDate']!,
        endDate: dates['endDate']!,
      ));
      setState(() {
        selectedLabel = 'Semanal';
        historyLabelsKey = UniqueKey();
      });
    }
  }

  Future<void> _onRefresh() async {
    _loadDefaultData();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return CustomScaffold(
      title: BienvenidaWidget(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomTitle(title: texts.control_panel),
              const SizedBox(height: 16),
              Text(
                texts.manega_monitor_appointments,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              HistoryLabels(
                key: historyLabelsKey,
                labels: labels,
                selectedLabel: selectedLabel,
                onSelected: (label) => setState(() => selectedLabel = label),
              ),
              const SizedBox(height: 16),
              CustomTitle(title: 'Rendimiento $selectedLabel:'),
              const SizedBox(height: 16),
              Text(
                texts.review_your_performance,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
              ),
              HistoryGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
