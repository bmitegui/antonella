import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/bottom_buttons_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/client/services/progress_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabSectionPageView extends StatefulWidget {
  final List<Widget> pages;
  final bool
      checkDateTime; // si queremos verificar date/time en ServicesSelectedBloc
  final String? titleText; // opcional
  final Widget? leadingWidget;

  const TabSectionPageView({
    super.key,
    required this.pages,
    this.checkDateTime = true,
    this.titleText,
    this.leadingWidget,
  });

  @override
  State<TabSectionPageView> createState() => _TabSectionPageViewState();
}

class _TabSectionPageViewState extends State<TabSectionPageView> {
  late PageController _pageController;
  int _currentPage = 0;
  Key _pageViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final state = sl<ServicesSelectedBloc>().state;
    bool onlyProducts = false;

    if (state is ServicesSelectedLoaded) {
      onlyProducts = state.services.isEmpty && state.products.isNotEmpty;
    }

    if (_currentPage < widget.pages.length - 1) {
      if (onlyProducts) {
        // Si solo hay productos, ir directo a la última página
        _pageController.jumpToPage(widget.pages.length - 1);
        setState(() => _currentPage = widget.pages.length - 1);
      } else {
        _checkDateTime();
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    }
  }

  void _previousPage() {
    final state = sl<ServicesSelectedBloc>().state;
    bool onlyProducts = false;

    if (state is ServicesSelectedLoaded) {
      onlyProducts = state.services.isEmpty && state.products.isNotEmpty;
    }

    if (_currentPage > 0) {
      if (onlyProducts) {
        // Si solo hay productos, ir directo a la primera página
        _pageController.jumpToPage(0);
        setState(() => _currentPage = 0);
      } else {
        _checkDateTime();
        _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    }
  }

  void _sendRequest() {
    _pageViewKey = UniqueKey();
    _currentPage = 0;
    _pageController.dispose();
    _pageController = PageController();
    setState(() {});
  }

  void _checkDateTime() {
    if (!widget.checkDateTime) return;

    final state = sl<ServicesSelectedBloc>().state;
    if (state is ServicesSelectedLoaded) {
      if (state.dateSelected == null) {
        sl<ServicesSelectedBloc>()
            .add(SelectDateTimeEvent(dateSelected: DateTime.now()));
      }
      if (state.timeSelected == null) {
        sl<ServicesSelectedBloc>().add(SelectTimeEvent(
            timeSelected: DateFormat('HH:mm').format(DateTime.now())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: _currentPage != 0
          ? (widget.leadingWidget ??
              ArrowBack(onBack: _previousPage)) // por defecto ArrowBack
          : null,
      title: _currentPage != 0
          ? (widget.titleText != null
              ? Text(widget.titleText!,
                  style: Theme.of(context).textTheme.titleMedium)
              : ProgressSearchWidget(page: _currentPage + 1))
          : (widget.titleText != null
              ? Text(widget.titleText!,
                  style: Theme.of(context).textTheme.titleMedium)
              : null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              key: _pageViewKey,
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              physics: const NeverScrollableScrollPhysics(),
              children: widget.pages,
            ),
          ),
          BottomButtonsSearchScreen(
            currentPage: _currentPage,
            nextPage: _nextPage,
            previousPage: _previousPage,
            sendRequest: _sendRequest,
          ),
        ],
      ),
    );
  }
}
