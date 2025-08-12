import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/employee/shimmer_history_labels.dart';
import 'package:antonella/features/user/presentation/bloc/employee_info/employee_info_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryLabels extends StatefulWidget {
  final List<String> labels;
  final String selectedLabel;
  final void Function(String) onSelected;
  const HistoryLabels(
      {super.key,
      required this.labels,
      required this.selectedLabel,
      required this.onSelected});

  @override
  State<HistoryLabels> createState() => _HistoryLabelsState();
}

class _HistoryLabelsState extends State<HistoryLabels> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeInfoBloc, EmployeeInfoState>(
        builder: (context, state) {
      return (state is EmployeeInfoLoaded)
          ? Column(children: [
              Wrap(
                  spacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: widget.labels.map((label) {
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
                        selected: widget.selectedLabel == label,
                        onSelected: (selected) {
                          final userState = sl<UserBloc>().state;
                          if (userState is UserAuthenticated) {
                            final dates =
                                obtenerRangoFechas(label.toUpperCase());
                            sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
                                employeeId: userState.user.id,
                                startDate: dates['startDate']!,
                                endDate: dates['endDate']!));
                            widget.onSelected(label);
                          }
                        });
                  }).toList()),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                    child: CustomTextFormFieldWidget(
                        readOnly: true,
                        onTap: () async {
                          final DateTime? dateTime = await selectDate(context);
                          if (dateTime != null) {
                            setState(() {
                              _startDateController = TextEditingController(
                                  text: formatDateTime(dateTime));
                            });
                          }
                        },
                        textEditingController: _startDateController,
                        title: "Fecha de inicio",
                        suffixIcon: Icon(Icons.date_range))),
                const SizedBox(width: 8),
                Expanded(
                    child: CustomTextFormFieldWidget(
                        readOnly: true,
                        onTap: () async {
                          final DateTime? dateTime = await selectDate(context);
                          if (dateTime != null) {
                            setState(() {
                              _endDateController = TextEditingController(
                                  text: formatDateTime(dateTime));
                            });
                          }
                        },
                        textEditingController: _endDateController,
                        title: "Fecha de fin",
                        suffixIcon: Icon(Icons.date_range)))
              ]),
              const SizedBox(height: 16),
              FilledButton(onPressed: () {}, child: Text('Filtrar datos'))
            ])
          : ShimmerHistoryLabels();
    });
  }
}
