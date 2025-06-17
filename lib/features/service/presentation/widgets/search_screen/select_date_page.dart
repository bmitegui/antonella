import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:flutter/material.dart';

class SelectDatePage extends StatelessWidget {
  const SelectDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProgressSearchWidget(page: 2),
              const SizedBox(height: 16),
              ActivityStateWidget(),
              const SizedBox(height: 16),
              SizedBox(
                  height: 400,
                  child: Expanded(child: CustomTableCalendarWidget()))
            ]));
  }
}
