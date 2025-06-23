import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/shimmer_history_labels.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryLabels extends StatelessWidget {
  final List<String> labels;
  final String selectedLabel;
  final void Function(String) onSelected;
  const HistoryLabels(
      {super.key,
      required this.labels,
      required this.selectedLabel,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeInfoBloc, EmployeeInfoState>(
        builder: (context, state) {
      return (state is EmployeeInfoLoaded)
          ? Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: labels.map((label) {
                return ChoiceChip(
                    avatar: SizedBox.shrink(),
                    avatarBoxConstraints: BoxConstraints.loose(Size.zero),
                    labelStyle: TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.transparent)),
                    backgroundColor: Colors.grey.shade300,
                    selectedColor: Color(0xFFF44565),
                    label: Text(label),
                    selected: selectedLabel == label,
                    onSelected: (selected) {
                      final userState = sl<UserBloc>().state;
                      if (userState is UserAuthenticated) {
                        final dates = obtenerRangoFechas(label.toUpperCase());
                        sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
                            employeeId: userState.user.id,
                            startDate: dates['startDate']!,
                            endDate: dates['endDate']!));
                        onSelected(label);
                      }
                    });
              }).toList())
          : ShimmerHistoryLabels();
    });
  }
}
