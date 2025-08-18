import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/employee_schedule/employee_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/core/constant/environment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListEmployeesWidget extends StatefulWidget {
  final List<ServiceEntity> services;
  final List<UserEntity> employees;

  const ListEmployeesWidget(
      {super.key, required this.services, required this.employees});

  @override
  State<ListEmployeesWidget> createState() => _ListEmployeesWidgetState();
}

class _ListEmployeesWidgetState extends State<ListEmployeesWidget> {
  String _employeeId = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return BlocConsumer<EmployeeScheduleBloc, EmployeeScheduleState>(
            listener: (context, stateShedule) {
          if (stateShedule is EmployeeScheduleLoaded) {
            final dates = stateShedule.dates;
            final dateSelected = state.dateSelected;
            final parts = state.timeSelected!.split(":");
            final timeSelected = DateTime(
              state.dateSelected!.year,
              state.dateSelected!.month,
              state.dateSelected!.day,
              int.parse(parts[0]),
              int.parse(parts[1]),
            );

            final available = isEmployeeAvailable(
              dates: dates,
              dateSelected: dateSelected!,
              timeSelected: timeSelected,
            );
            if (available) {
              widget.services
                  .map((service) => context.read<ServicesSelectedBloc>().add(
                      SelectEmployeeEvent(
                          serviceId: service.id, employeeId: _employeeId)))
                  .toList();
              _employeeId = '';
              Navigator.pop(context);
            } else {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                    message:
                        "El especialista se encuentra ocupado en ese horario"),
              );
            }
          }
        }, builder: (context, stateShedule) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.employees.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final employee = widget.employees[index];

                final bool isSelected = widget.services.length > 1
                    ? isEmployeeSelectedForAnyService(
                      employeeId: employee.id,
                        employeeIds: state.employeeIds,
                        services: widget.services,
                        category: widget.services[0].type)
                    : state.employeeIds?[widget.services[0].id] == employee.id;

                Widget trailingWidget;
                if (isSelected) {
                  trailingWidget =
                      const Icon(Icons.check_circle, color: Colors.green);
                } else if (_employeeId == employee.id) {
                  trailingWidget = CircularProgressIndicator();
                } else {
                  trailingWidget = FilledButton(
                      onPressed: () {
                        _employeeId = employee.id;
                        context.read<EmployeeScheduleBloc>().add(
                            GetEmployeeScheduleEvent(employeeId: employee.id));
                      },
                      child: const Text("Seleccionar"));
                }

                return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                        backgroundImage: employee.photoUrl != null
                            ? NetworkImage(
                                Environment.apiUrl + employee.photoUrl!)
                            : null,
                        backgroundColor: Colors.grey,
                        radius: 24,
                        child: employee.photoUrl == null
                            ? const Icon(Icons.person, color: Colors.white)
                            : null),
                    title: Text(employee.name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    trailing: trailingWidget);
              });
        });
      }
      return const SizedBox.shrink();
    });
  }
}
