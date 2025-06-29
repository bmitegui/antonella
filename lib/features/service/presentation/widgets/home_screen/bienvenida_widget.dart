import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BienvenidaWidget extends StatelessWidget {
  const BienvenidaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return (state is UserAuthenticated)
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: 'Bienvenid@, ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                                text: state.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF44565)))
                          ]))),
              BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
                  builder: (context, state) {
                if (state is ProductsSelectedLoaded &&
                    state.products.isNotEmpty) {
                  return IconButton(
                      onPressed: () => navigateWithSlideTransition(
                          context, ShoppingCartScreen()),
                      icon:
                          Icon(Icons.shopping_cart, color: Color(0xFFF44565)));
                } else {
                  return SizedBox.shrink();
                }
              })
            ])
          : const SizedBox.shrink();
    });
  }
}
