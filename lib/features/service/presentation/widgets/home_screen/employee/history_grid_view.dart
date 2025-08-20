import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/history_container.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/shimmer_history_container.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryGridView extends StatelessWidget {
  const HistoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<EmployeeInfoBloc, EmployeeInfoState>(
        builder: (context, state) {
      List<dynamic> data = [
        {
          'title': texts.total_billed,
          'valor': '\$325.0',
          'image': 'assets/img/total-facturado.png',
          'color': Color(0xFF009387)
        },
        {
          'title': 'Total de citas',
          'valor': '23',
          'image': 'assets/img/total-citas.png',
          'color': Color(0xFF2995CD)
        },
        {
          'title': 'Total pagado',
          'valor': '\$24',
          'image': 'assets/img/total-pagado.png',
          'color': Color(0xFF399F49)
        },
        {
          'title': 'Total por pagar',
          'valor': '\$24',
          'image': 'assets/img/total-por-pagar.png',
          'color': Color(0xFF399F49)
        },
        {
          'title': 'Restante',
          'valor': '\$24',
          'image': 'assets/img/restante.png',
          'color': Color(0xFF399F49)
        }
      ];
      bool isLoading = false;
      if (state is EmployeeInfoLoaded) {
        data[0]['valor'] = '\$${state.employeeInfoEntity.totalFacturado}';
        data[1]['valor'] = '${state.employeeInfoEntity.numClientes}';
        data[2]['valor'] = '\$${state.employeeInfoEntity.totalPagado}';
        data[3]['valor'] = '\$${state.employeeInfoEntity.totalPorPagar}';
        data[4]['valor'] = '\$${state.employeeInfoEntity.restante}';
      } else if (state is EmployeeInfoLoading) {
        isLoading = true;
      } else if (state is EmployeeInfoError) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                mapFailureToMessage(context: context, failure: state.failure)));
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
