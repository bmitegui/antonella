import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesRowsInfoToClient extends StatelessWidget {
  final List<UserEntity> employees;
  const EmployeesRowsInfoToClient({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserAuthenticated && state.user.rol == Rol.cliente) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Divider(color: Colors.grey.shade300, thickness: 1),
          const SizedBox(height: 8),
          Text('Especialistas:', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),

          // Lista de empleados
          ...List.generate(employees.length, (index) {
            final employee = employees[index];
            return Column(children: [
              Row(children: [
                const Icon(Icons.person, size: 16, color: Colors.black54),
                const SizedBox(width: 6),
                Text(employee.name)
              ]),
              // Row(children: [
              //   const Icon(Icons.email, size: 16, color: Colors.black54),
              //   const SizedBox(width: 6),
              //   Text(employee.email)
              // ]),
              if (index != employees.length - 1)
                Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Divider(color: Colors.grey.shade300, thickness: 1))
            ]);
          })
        ]);
      }
      return const SizedBox.shrink();
    });
  }
}
