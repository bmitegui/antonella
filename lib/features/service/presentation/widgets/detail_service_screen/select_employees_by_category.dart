import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/employees_selected_widget.dart';
import 'package:antonella/features/user/presentation/bloc/employees/employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectEmployeesByCategory extends StatelessWidget {
  const SelectEmployeesByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Especialistas por categoría:',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 16),
          ...getUniqueCategoriesText(context, state.services).map((categoria) {
            final category = stringToType(categoria.toUpperCase());
            final bool isSelected = allEmployeesSelectedByCategory(
                employeeIds: state.employeeIds,
                services: state.services,
                category: category);
            return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categoria,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      CustomElevatedButton(
                          onPressed: () async {
                            sl<EmployeesBloc>()
                                .add(GetEmployeesEvent(serviceType: category));
                            await showModalBottomSheet<List>(
                                scrollControlDisabledMaxHeightRatio: 1,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (BuildContext context) {
                                  return EmployeesSelectedWidget(
                                      services: state.services
                                          .where((s) => s.type == category)
                                          .toList());
                                });
                          },
                          text: (isSelected)
                              ? "Cambiar Especialista"
                              : "Elegir Especialista",
                          backgroundColor: (isSelected)
                              ? Colors.green
                              : const Color(0xFFF44565)),
                    ]));
          })
        ]);
      }
      return SizedBox.shrink();
    });
  }
}
