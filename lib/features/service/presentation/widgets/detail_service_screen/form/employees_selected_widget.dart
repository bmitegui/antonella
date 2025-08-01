import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/list_employees_widget.dart';
import 'package:antonella/features/user/presentation/bloc/employees/employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesSelectedWidget extends StatelessWidget {
  final ServiceEntity service;
  const EmployeesSelectedWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
      return CustomModalBottomSheetWidget(
          closeAction: false,
          title:
              "Empleados de: ${getCategoryText(context: context, serviceCategory: service.type)}",
          body: (state is EmployeesLoaded)
              ? state.listEmployees.isNotEmpty
                  ? ListEmployeesWidget(
                      serviceId: service.id, employees: state.listEmployees)
                  : Text('No existen empleados para esta categoría.')
              : (state is EmployeesError)
                  ? Text(mapFailureToMessage(
                      context: context, failure: state.failure))
                  : const CircularProgressIndicator());
    });
  }
}
