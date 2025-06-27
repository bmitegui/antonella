import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/screens/appointment/appointment_client_screen.dart';
import 'package:antonella/features/service/presentation/screens/appointment/appointment_employee_screen.dart';
import 'package:antonella/features/service/presentation/screens/chat_screen/chats_screen.dart';
import 'package:antonella/features/service/presentation/screens/chat_screen/visualize_chat_user_screen.dart';
import 'package:antonella/features/service/presentation/screens/home_screen/home_screen_client.dart';
import 'package:antonella/features/service/presentation/screens/home_screen/home_screen_employee.dart';
import 'package:antonella/features/service/presentation/screens/notifications_screen.dart';
import 'package:antonella/features/service/presentation/screens/search_screen/search_screen_client.dart';
import 'package:antonella/core/widgets/custom_bottom_navigator_bar.dart';
import 'package:antonella/features/service/presentation/screens/search_screen/search_screen_employee.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:antonella/features/user/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({super.key});

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  late PageController _pageController;
  late int _currentIndex;

  final List<Widget> _contentPagesCliente = const [
    AppointmentClientScreen(),
    SearchScreenClient(),
    HomeScreenClient(),
    VisualizeChatUserScreen(),
    NotificationsScreen(),
    SettingsScreen()
  ];

  final List<Widget> _contentPagesEmpleado = const [
    AppointmentEmployeeScreen(),
    SearchScreenEmployee(),
    HomeScreenEmployee(),
    NotificationsScreen(),
    SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    _currentIndex = 2;
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
      if (userState.user.rol == Rol.cliente) {
        sl<MessagesBloc>().add(GetMessagesEvent());
        sl<ServiceBloc>().add(GetServicesEvent());
        sl<ProductsBloc>().add(GetProductsEvent());
      } else {
        final dates = obtenerRangoFechas('SEMANAL');
        sl<EmployeeInfoBloc>().add(GetEmployeeInfoEvent(
            employeeId: userState.user.id,
            startDate: dates['startDate']!,
            endDate: dates['endDate']!));
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      final List<Widget> contentPages =
          (state is UserAuthenticated && state.user.rol == Rol.empleado)
              ? _contentPagesEmpleado
              : _contentPagesCliente;

      return Scaffold(
          extendBody: true,
          body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: contentPages.map((Widget content) {
                return content;
              }).toList()),
          bottomNavigationBar: CustomBottomNavigatorBar(
              activeIndex: _currentIndex,
              onTabChange: (index) {
                FocusScope.of(context).unfocus();
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(index);
              }));
    });
  }
}
