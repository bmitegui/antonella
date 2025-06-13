import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        DateTime hora = (state.timeSelected != null)
            ? DateFormat("hh:mm a").parse(state.timeSelected!)
            : DateTime.now();
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0XFFFAE2E1)),
            child: TimePickerSpinner(
                time: hora,
                normalTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
                highlightedTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                        color: Color(0xFFF44565), fontWeight: FontWeight.bold),
                alignment: Alignment.center,
                is24HourMode: false,
                spacing: 16,
                minutesInterval: 1,
                onTimeChange: (time) {
                  context.read<ServicesSelectedBloc>().add(SelectTimeEvent(
                      timeSelected: DateFormat('hh:mm a').format(time)));
                }));
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
