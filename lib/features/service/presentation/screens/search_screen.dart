import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/confirmation_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_date_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_services_page.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_time_page.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    final title = _currentPage == 0
        ? 'Búsqueda'
        : _currentPage == 1
            ? 'Agenda'
            : _currentPage == 2
                ? 'Agenda'
                : 'Confirmación';
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
            leading:
                _currentPage != 0 ? ArrowBack(onBack: _previousPage) : null,
            backgroundColor: Color(0xFFF0F0F0),
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Color(0xFFF44565)))),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Column(children: [
                    Expanded(
                        child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            children: [
                          SelectServicesPage(),
                          SelectDatePage(),
                          SelectTimePage(),
                          ConfirmationServicesPage()
                        ]))
                  ]))),
          BottomButtonsSearchScreen(
              currentPage: _currentPage,
              nextPage: _nextPage,
              previousPage: _previousPage,
              sendRequest: _sendRequest)
        ]));
  }
}
