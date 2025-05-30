import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BienvenidaWidget extends StatelessWidget {
  const BienvenidaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return (state is UserAuthenticated)
          ? Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Bienvenid@, ',
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                      children: [
                        TextSpan(
                            text: capitalize(state.user.name),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Color(0xFFF44565)))
                      ])))
          : const SizedBox.shrink();
    });
  }
}
