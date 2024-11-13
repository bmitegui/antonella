import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BienvenidaWidget extends StatelessWidget {
  const BienvenidaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return (state is UserAuthenticated)
          ? RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Bienvenid@, ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: themeClass.lightEighthColor),
                  children: [
                    TextSpan(
                        text: state.user.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: themeClass.lightPrimaryColor))
                  ]))
          : const SizedBox.shrink();
    });
  }
}
