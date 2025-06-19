import 'package:antonella/features/service/presentation/widgets/home_screen/history_container.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/shimmer_history_container.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryGridView extends StatelessWidget {
  const HistoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeInfoBloc, EmployeeInfoState>(
        builder: (context, state) {
      List<dynamic> data = [
        {
          'title': 'Total Facturado',
          'valor': '\$325.0',
          'image': 'assets/svg/facturas.svg',
          'color': Color(0xFF009387)
        },
        {
          'title': 'Total Clientes',
          'valor': '23',
          'image': 'assets/svg/roles.svg',
          'color': Color(0xFF2995CD)
        },
        {
          'title': 'Total a Recibir',
          'valor': '\$24',
          'image': 'assets/svg/ganancias.svg',
          'color': Color(0xFF399F49)
        }
      ];
      bool isLoading = false;
      if (state is EmployeeInfoLoaded) {
        data[0]['valor'] = '\$${state.employeeInfoEntity.facturado}';
        data[1]['valor'] = '${state.employeeInfoEntity.numClientes}';
        data[2]['valor'] = '\$${state.employeeInfoEntity.pagado}';
      } else if (state is EmployeeInfoLoading) {
        isLoading = true;
      } else if (state is EmployeeInfoError) {
        return Padding(
            padding: const EdgeInsets.all(16.0), child: Text(state.message));
      }

      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 100,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemBuilder: (context, index) {
                final item = data[index];
                return isLoading
                    ? const ShimmerHistoryContainer()
                    : HistoryContainer(
                        title: item['title']!,
                        valor: item['valor']!,
                        image: item['image']!,
                        color: item['color']!);
              }));
    });
  }
}
