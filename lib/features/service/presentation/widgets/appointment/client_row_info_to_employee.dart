import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientRowInfoToEmployee extends StatelessWidget {
  const ClientRowInfoToEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return (state is UserAuthenticated)
          ? (state.user.rol == Rol.empleado)
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  const SizedBox(height: 8),
                  Text('Cliente', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.person, size: 16, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(state.user.name)
                  ])
                ])
              : const SizedBox.shrink()
          : const SizedBox.shrink();
    });
  }
}
