import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/custom_table_calendar_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/status_legend_widget.dart';
import 'package:flutter/material.dart';

class SelectDatePage extends StatelessWidget {
  final Function() nextPage;
  final Function() previousPage;
  const SelectDatePage(
      {super.key, required this.nextPage, required this.previousPage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const ProgressSearchWidget(page: 2),
          const SizedBox(height: 4),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StatusLegend()),
          const SizedBox(height: 16),
          const Expanded(child: CustomTableCalendarWidget()),
          BottomButtonsSearchScreen(
              previousPage: previousPage, nextPage: nextPage)
        ]));
  }
}
