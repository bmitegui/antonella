import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/widgets/custom_title_separator_widget.dart';
import 'package:antonella/features/service/data/datasources/remote/service_remote_data_source.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTimesWidget extends StatelessWidget {
  const ListTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return SingleChildScrollView(
            child: Column(
                children: hours.entries.map((entry) {
          return Column(children: [
            CustomTitleSeparatorWidget(text: entry.key),
            Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: (hours[entry.key] as List<String>).map((hour) {
                  return ChoiceChip(
                      side: BorderSide.none,
                      label: Text(hour),
                      selected: state.timeSelected == hour,
                      onSelected: (selected) {
                        if (selected) {
                          context.read<ServicesSelectedBloc>().add(
                              SelectTimeEvent(
                                  listServicesSelected:
                                      state.listServicesSelected,
                                  dateSelected: state.dateSelected,
                                  timeSelected: hour));
                        }
                      },
                      selectedColor: Colors.green,
                      checkmarkColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.grey.shade400);
                }).toList()),
            const SizedBox(height: 8)
          ]);
        }).toList()));
      }
      return const SizedBox.shrink();
    });
  }
}
