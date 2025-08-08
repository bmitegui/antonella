// import 'package:antonella/core/injection/injection_container.dart';
// import 'package:antonella/core/l10n/app_localizations.dart';
// import 'package:antonella/core/widgets/arrow_back.dart';
// import 'package:antonella/core/widgets/custom_local_svg_image.dart';
// import 'package:antonella/core/widgets/custom_scaffold.dart';
// import 'package:antonella/features/product/domain/entities/product_entity.dart';
// import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
// import 'package:antonella/features/product/presentation/bloc/shopping_cart/cart_bloc.dart';
// import 'package:antonella/features/service/presentation/widgets/appointment/payment_method.dart';
// import 'package:antonella/features/user/domain/entities/entities.dart';
// import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// class OptionsPayShoppingCartScreen extends StatefulWidget {
//   final List<ProductEntity> products;
//   const OptionsPayShoppingCartScreen({super.key, required this.products});

//   @override
//   State<OptionsPayShoppingCartScreen> createState() =>
//       _OptionsPayShoppingCartScreenState();
// }

// class _OptionsPayShoppingCartScreenState
//     extends State<OptionsPayShoppingCartScreen> {
//   String _metodo = "EFECTIVO";

//   @override
//   Widget build(BuildContext context) {
//     final texts = AppLocalizations.of(context)!;
//     UserEntity? userEntity;

//     final userState = sl<UserBloc>().state;
//     if (userState is UserAuthenticated) {
//       userEntity = userState.user;
//     }

//     return CustomScaffold(
//         leading: ArrowBack(),
//         text: texts.pay_products,
//         child: Column(children: [
//           const SizedBox(height: 16),
//           Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16), color: Colors.white),
//               child: Column(children: [
//                 Row(children: [
//                   Text(texts.billing_information),
//                   Spacer(),
//                   Text(texts.change,
//                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                           color: Color(0xFFF44565),
//                           decoration: TextDecoration.underline,
//                           decorationColor: Color(0xFFF44565)))
//                 ]),
//                 Divider(color: Colors.grey.shade300),
//                 const SizedBox(height: 8),
//                 Row(children: [
//                   CustomLocalSvgImage(
//                       assetPath: 'assets/svg/factura.svg',
//                       height: 64,
//                       color: Color(0xFFF44565)),
//                   const SizedBox(width: 16),
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(userEntity!.name,
//                             style: Theme.of(context).textTheme.titleMedium),
//                         const SizedBox(height: 4),
//                         Text(userEntity.dni)
//                       ])
//                 ])
//               ])),
//           const SizedBox(height: 16),
//           PaymentMethod(
//               metodo: _metodo,
//               onChange: (value) => setState(() => _metodo = value)),
//           const SizedBox(height: 16),
//           const SizedBox(height: 16),
//           BlocConsumer<CartBloc, CartState>(listener: (context, state) {
//             if (state is CartLoaded) {
//               sl<ProductsSelectedBloc>().add(ClearProductSelectedEvent());
//               showTopSnackBar(Overlay.of(context),
//                   const CustomSnackBar.success(message: 'Productos comprados'));
//               Navigator.pop(context);
//               Navigator.pop(context);
//             }
//           }, builder: (context, state) {
//             return (state is CartLoading)
//                 ? CircularProgressIndicator()
//                 : FilledButton(
//                     onPressed: () async {
//                       context
//                           .read<CartBloc>()
//                           .add(AddToCart(products: widget.products));
//                     },
//                     child: (_metodo == "EFECTIVO")
//                         ? Text(texts.confirm_purchase)
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [Text(texts.pay_now)]));
//           })
//         ]));
//   }
// }
