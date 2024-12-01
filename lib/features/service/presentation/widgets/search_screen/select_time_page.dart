import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_times_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/progress_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/status_legend_widget.dart';
import 'package:flutter/material.dart';

class SelectTimePage extends StatelessWidget {
  final Function() previousPage;
  final Function() nextPage;
  const SelectTimePage(
      {super.key, required this.previousPage, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 3),
            const SizedBox(height: 4),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StatusLegend()),
          const SizedBox(height: 16),
          const Expanded(child: ListTimesWidget()),
          const SizedBox(height: 16),
          BottomButtonsSearchScreen(
              previousPage: previousPage, nextPage: nextPage)
        ]));
  }
}
