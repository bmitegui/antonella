import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/custom_table_calendar.dart';
import 'package:flutter/material.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({super.key});

  @override
  State<SelectDatePage> createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 70),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              ActivityStateWidget(),
              const SizedBox(height: 16),
              SizedBox(height: 500, child: CustomTableCalendar())
            ]));
  }
}
