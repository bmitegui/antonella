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

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
            backgroundColor: Color(0xFFF0F0F0),
            title: Text('Búsqueda',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Color(0xFFF44565)))),
        body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Column(children: [
              Expanded(
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      children: [
                    SelectServicesPage(nextPage: _nextPage),
                    SelectDatePage(
                        nextPage: _nextPage, previousPage: _previousPage),
                    SelectTimePage(
                        previousPage: _previousPage, nextPage: _nextPage),
                    ConfirmationServicesPage(
                        previousPage: _previousPage,
                        onSend: () => _pageController.jumpTo(0))
                  ]))
            ])));
  }
}
