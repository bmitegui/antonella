import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusLabelAppointment extends StatelessWidget {
  final Function(ProgressStatus) onSelect;
  const StatusLabelAppointment({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      int pendientesCount = 0;
      int enCursoCount = 0;
      int finalizadasCount = 0;

      if (state is OrdersLoaded) {
        List<AppointmentEntity> appointments =
            state.orders.expand((order) => order.appointments).toList();

        pendientesCount = appointments
            .where((a) => a.status == ProgressStatus.pendiente)
            .length;
        enCursoCount = appointments
            .where((a) => a.status == ProgressStatus.enProgreso)
            .length;
        finalizadasCount = appointments
            .where((a) => a.status == ProgressStatus.finalizado)
            .length;
      }

      final List<Map<String, dynamic>> data = [
        {
          'title': 'Pendientes',
          'cant': pendientesCount,
          'color': Color(0xFFFBB03B)
        },
        {'title': 'En curso', 'cant': enCursoCount, 'color': Color(0xFF39B44A)},
        {
          'title': 'Finalizadas',
          'cant': finalizadasCount,
          'color': Color(0xFF0070BA)
        }
      ];

      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: data
              .map((element) => Column(children: [
                    GestureDetector(
                      onTap: () =>
                          onSelect(stringToProgressStatus(element['title'])),
                      child: Container(
                        width: 92,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: element['color'],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          element['cant'].toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(element['title'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black54))
                  ]))
              .toList());
    });
  }
}
