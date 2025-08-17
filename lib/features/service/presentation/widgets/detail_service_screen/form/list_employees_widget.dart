import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:flutter/material.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/core/constant/environment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEmployeesWidget extends StatelessWidget {
  final String serviceId;
  final Function(bool data)? onSelected;
  final List<UserEntity> employees;

  const ListEmployeesWidget(
      {super.key,
      required this.serviceId,
      required this.employees,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
      builder: (context, state) {
        if (state is ServicesSelectedLoaded) {
          final hasSelected = state.employeeIds?[serviceId] != null;

          if (onSelected != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onSelected!(hasSelected);
            });
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: employees.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final employee = employees[index];
              final isSelected = state.employeeIds?[serviceId] == employee.id;

              Widget trailingWidget;
              if (isSelected) {
                trailingWidget =
                    const Icon(Icons.check_circle, color: Colors.green);
              } else {
                trailingWidget = FilledButton(
                  onPressed: () => context.read<ServicesSelectedBloc>().add(
                        SelectEmployeeEvent(
                          serviceId: serviceId,
                          employeeId: employee.id,
                        ),
                      ),
                  child: const Text("Seleccionar"),
                );
              }

              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundImage: employee.photoUrl != null
                      ? NetworkImage(Environment.apiUrl + employee.photoUrl!)
                      : null,
                  backgroundColor: Colors.grey,
                  radius: 24,
                  child: employee.photoUrl == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                title: Text(
                  employee.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: trailingWidget,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
