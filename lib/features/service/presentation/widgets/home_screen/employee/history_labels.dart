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

  Map<String, String> dates = {};
  String? selectedLabel;
  bool isFilterEnabled = false;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    selectedLabel = widget.selectedLabel;

    _setInitialDates();
  }

  void _setInitialDates() {
    dates = obtenerRangoFechas(selectedLabel!.toUpperCase());
    _startDateController.text = dates['startDate'] ?? '';
    _endDateController.text = dates['endDate'] ?? '';
    isFilterEnabled = false;
  }

  void _updateDatesFromLabel(String label) {
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      dates = obtenerRangoFechas(label.toUpperCase());

      _startDateController.text = dates['startDate'] ?? '';
      _endDateController.text = dates['endDate'] ?? '';

      setState(() {
        selectedLabel = label;
        isFilterEnabled = false;
      });

      sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
        employeeId: userState.user.id,
        startDate: dates['startDate']!,
        endDate: dates['endDate']!,
      ));

      widget.onSelected(label);
    }
  }

  void _onDateChanged() {
    if (_startDateController.text != dates['startDate'] ||
        _endDateController.text != dates['endDate']) {
      setState(() {
        selectedLabel = null; 
        isFilterEnabled = true; 
      });
    } else {
      setState(() {
        isFilterEnabled = false;
      });
    }
  }

  void _filterByCustomDates() {
    if (!isFilterEnabled) return;

    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
        employeeId: userState.user.id,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      ));

      setState(() {
        isFilterEnabled = false;
      });
    }
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
                      labelStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.transparent),
                      ),
                      backgroundColor: Colors.grey.shade300,
                      selectedColor: Color(0xFFF44565),
                      label: Text(label),
                      selected: selectedLabel == label,
                      onSelected: (selected) => _updateDatesFromLabel(label),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(
                    child: CustomTextFormFieldWidget(
                      readOnly: true,
                      onTap: () async {
                        final dateTime = await selectDate(context);
                        if (dateTime != null) {
                          _startDateController.text = formatDateTime(dateTime);
                          _onDateChanged();
                        }
                      },
                      textEditingController: _startDateController,
                      title: "Fecha de inicio",
                      suffixIcon: Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextFormFieldWidget(
                      readOnly: true,
                      onTap: () async {
                        final dateTime = await selectDate(context);
                        if (dateTime != null) {
                          _endDateController.text = formatDateTime(dateTime);
                          _onDateChanged();
                        }
                      },
                      textEditingController: _endDateController,
                      title: "Fecha de fin",
                      suffixIcon: Icon(Icons.date_range),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: isFilterEnabled ? _filterByCustomDates : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      isFilterEnabled ? Colors.pinkAccent : Colors.grey.shade400,
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white), // color del texto
                  ),
                  child: Text('Filtrar datos'),
                )
              ])
            : ShimmerHistoryLabels();
      },
    );
  }
}
