import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/widgets/history_labels.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/history_grid_view.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreenEmpleado extends StatefulWidget {
  const HomeScreenEmpleado({super.key});

  @override
  State<HomeScreenEmpleado> createState() => _HomeScreenEmpleadoState();
}

class _HomeScreenEmpleadoState extends State<HomeScreenEmpleado> {
  final List<String> labels = ['Semanal', 'Mensual', 'Anual'];
  String selectedLabel = 'Semanal';
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: BienvenidaWidget(),
        body: RefreshIndicator(
            onRefresh: () async {
              final userState = sl<UserBloc>().state;
              if (userState is UserAuthenticated) {
                final dates = obtenerRangoFechas('SEMANAL');
                sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
                    employeeId: userState.user.id,
                    startDate: dates['startDate']!,
                    endDate: dates['endDate']!));
              }
            },
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  CustomTitle(title: 'Panel de control'),
                  const SizedBox(height: 16),
                  Text('Gestiona y supervisa tus citas de manera eficiente.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey)),
                  const SizedBox(height: 16),
                  HistoryLabels(
                      labels: labels,
                      selectedLabel: selectedLabel,
                      onSelected: (label) =>
                          setState(() => selectedLabel = label)),
                  const SizedBox(height: 16),
                  CustomTitle(title: 'Rendimiento $selectedLabel:'),
                  const SizedBox(height: 16),
                  Text('Revisa tu rendimiento y asegura un buen desempeño',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey)),
                  HistoryGridView()
                ]))));
  }
}
