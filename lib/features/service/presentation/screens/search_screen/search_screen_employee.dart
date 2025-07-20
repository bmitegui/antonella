import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/filter_list_appointment.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/employee/filter_label_appoinment.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/employee/status_label_appointment.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenEmployee extends StatefulWidget {
  const SearchScreenEmployee({super.key});

  @override
  State<SearchScreenEmployee> createState() => _SearchScreenEmployeeState();
}

class _SearchScreenEmployeeState extends State<SearchScreenEmployee> {
  ProgressStatus? _status;
  String? _value = "Recientes";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        text: 'Buscar cita',
        body: RefreshIndicator(onRefresh: () async {
          final userState = sl<UserBloc>().state;
          if (userState is UserAuthenticated) {
            sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
            _status = null;
          }
        }, child:
            BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
          return SingleChildScrollView(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 100),
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                CustomTitle(title: 'Estados'),
                const SizedBox(height: 16),
                StatusLabelAppointment(
                    onSelect: (value) => setState(() => _status = value)),
                const SizedBox(height: 16),
                CustomTitle(title: 'Ordenar'),
                const SizedBox(height: 16),
                FilterLabelAppoinment(
                  onSelect: (data) => setState(() => _value = data)
                ),
                const SizedBox(height: 16),
                CustomTitle(title: 'Citas'),
                const SizedBox(height: 16),
                FilterListAppointment(status: _status, value: _value)
              ]));
        })));
  }
}
