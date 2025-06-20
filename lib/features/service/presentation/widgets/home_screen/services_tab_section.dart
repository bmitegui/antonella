import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_time_page.dart';
import 'package:flutter/material.dart';

class ServicesTabSection extends StatefulWidget {
  const ServicesTabSection({super.key});

  @override
  State<ServicesTabSection> createState() => _ServicesTabSectionState();
}

class _ServicesTabSectionState extends State<ServicesTabSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _sendRequest() {
    _pageController.jumpTo(0);
  }

  void _previousPage() {
    if (_currentPage > 0) {
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
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: PageView(
                      clipBehavior: Clip.antiAlias,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      children: [
                        SelectServicesPage(),
                        SelectDatePage(),
                        SelectTimePage(),
                        ConfirmationServicesPage()
                      ]))),
          BottomButtonsSearchScreen(
              currentPage: _currentPage,
              nextPage: _nextPage,
              previousPage: _previousPage,
              sendRequest: _sendRequest)
        ]));
  }
}
