import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabChange;
  const CustomBottomNavigatorBar(
      {super.key, required this.activeIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      Rol rol = Rol.cliente;
      if (state is UserAuthenticated && state.user.rol == Rol.empleado) {
        rol = Rol.empleado;
      }

      return CircleNavBar(
          onTap: onTabChange,
          activeIndex: activeIndex,
          activeIcons: [
            Icon(Icons.calendar_month, color: Color(0xFFF44565)),
            Icon(Icons.search, color: Color(0xFFF44565)),
            Icon(Icons.home_rounded, color: Color(0xFFF44565)),
            if (rol == Rol.cliente) Icon(Icons.chat, color: Color(0xFFF44565)),
            Icon(Icons.notifications_rounded, color: Color(0xFFF44565)),
            Icon(Icons.settings_rounded, color: Color(0xFFF44565)),
          ],
          inactiveIcons: [
            Icon(Icons.calendar_month, color: Color(0XFFCACACA)),
            Icon(Icons.search, color: Color(0XFFCACACA)),
            Icon(Icons.home_rounded, color: Color(0XFFCACACA)),
            if (rol == Rol.cliente) Icon(Icons.chat, color: Color(0XFFCACACA)),
            Icon(Icons.notifications_rounded, color: Color(0XFFCACACA)),
            Icon(Icons.settings_rounded, color: Color(0XFFCACACA)),
          ],
          color: Colors.white);
    });
  }
}
