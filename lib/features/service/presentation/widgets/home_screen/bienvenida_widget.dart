import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BienvenidaWidget extends StatelessWidget {
  const BienvenidaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return (state is UserAuthenticated)
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: texts.welcome_user,
                          style: textTheme.titleMedium!
                              .copyWith(color: colorScheme.onSurface),
                          children: [
                            TextSpan(
                                text: state.user.name,
                                style: textTheme.titleMedium)
                          ]))),
              BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
                  builder: (context, state) {
                if ((state is ProductsSelectedLoaded &&
                        state.products.isNotEmpty) ||
                    state is ServicesSelectedBloc) {
                  return IconButton(
                      onPressed: () => navigateWithSlideTransition(
                          context, ShoppingCartScreen()),
                      icon: Icon(Icons.shopping_cart,
                          color: colorScheme.primary));
                } else {
                  return SizedBox.shrink();
                }
              })
            ])
          : const SizedBox.shrink();
    });
  }
}
