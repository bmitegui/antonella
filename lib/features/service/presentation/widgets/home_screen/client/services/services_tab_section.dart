import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/select_time_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesTabSection extends StatefulWidget {
  const ServicesTabSection({super.key});

  @override
  State<ServicesTabSection> createState() => _ServicesTabSectionState();
}

class _ServicesTabSectionState extends State<ServicesTabSection> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  Key _pageViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      final state = sl<ServicesSelectedBloc>().state;
      if (state is ServicesSelectedLoaded) {
        if ((state).dateSelected == null) {
          sl<ServicesSelectedBloc>()
              .add(SelectDateTimeEvent(dateSelected: DateTime.now()));
        }
        if ((state).timeSelected == null) {
          sl<ServicesSelectedBloc>().add(SelectTimeEvent(
              timeSelected: DateFormat('HH:mm').format(DateTime.now())));
        }
      }

      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _sendRequest() {
    _pageViewKey = UniqueKey();
    _currentPage = 0;
    _pageController.dispose();
    _pageController = PageController();
    setState(() {});
  }

  void _previousPage() {
    if (_currentPage > 0) {
      final state = sl<ServicesSelectedBloc>().state;
      if (state is ServicesSelectedLoaded) {
        if ((state).dateSelected == null) {
          sl<ServicesSelectedBloc>()
              .add(SelectDateTimeEvent(dateSelected: DateTime.now()));
        }
        if ((state).timeSelected == null) {
          sl<ServicesSelectedBloc>().add(SelectTimeEvent(
              timeSelected: DateFormat('HH:mm').format(DateTime.now())));
        }
      }
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        leading: _currentPage != 0 ? ArrowBack(onBack: _previousPage) : null,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: PageView(
                  key: _pageViewKey,
                  clipBehavior: Clip.antiAlias,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  children: [
                SelectServicesPage(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SelectDatePage(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SelectTimePage(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ConfirmationServicesPage(),
                )
              ])),
          BottomButtonsSearchScreen(
              currentPage: _currentPage,
              nextPage: _nextPage,
              previousPage: _previousPage,
              sendRequest: _sendRequest)
        ]));
  }
}
