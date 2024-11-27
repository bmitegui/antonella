import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/features/service/presentation/widgets/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/progress_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_filter_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_info_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PageController _pageController = PageController();
  late List<String> _servicesSelected;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _servicesSelected = ['1', '4'];
  }

  // Métodos para navegar entre páginas
  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: themeClass.lightscaffoldBackgroundColor,
            title: Text('Agendar cita',
                style: Theme.of(context).textTheme.titleMedium),
            actions: [Image.asset('assets/icon/logo.png')]),
        body: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
            child: Column(children: [
              Expanded(
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                    _buildPage1(),
                    _buildPage2(),
                    _buildPage3(),
                    _buildPage4()
                  ]))
            ])));
  }

  Widget _buildPage1() {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 1),
          const SizedBox(height: 16),
          const ServicesFilterWidget(),
          const SizedBox(height: 16),
          Expanded(
              child: SingleChildScrollView(
                  child:
                      ServicesInfoWidget(servicesSelected: _servicesSelected))),
          const SizedBox(height: 16),
          BottomButtonsSearchScreen(
              servicesSelected: _servicesSelected,
              enableChat: true,
              nextPage: () => _nextPage())
        ]));
  }

  Widget _buildPage2() {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 2),
          const SizedBox(height: 16),
          const Spacer(),
          const SizedBox(height: 16),
          BottomButtonsSearchScreen(
              enableChat: true,
              servicesSelected: _servicesSelected,
              previousPage: () => _previousPage(),
              nextPage: () => _nextPage())
        ]));
  }

  Widget _buildPage3() {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 3),
          const SizedBox(height: 16),
          const Spacer(),
          const SizedBox(height: 16),
          BottomButtonsSearchScreen(
              enableChat: true,
              servicesSelected: _servicesSelected,
              previousPage: () => _previousPage(),
              nextPage: () => _nextPage())
        ]));
  }

  Widget _buildPage4() {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const ProgressSearchWidget(page: 4),
          const SizedBox(height: 16),
          const Spacer(),
          const SizedBox(height: 16),
          BottomButtonsSearchScreen(
              enableChat: true,
              servicesSelected: _servicesSelected,
              previousPage: () => _previousPage())
        ]));
  }
}
