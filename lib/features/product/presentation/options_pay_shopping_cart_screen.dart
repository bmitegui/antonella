import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/shopping_cart/cart_bloc.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/pay_order/pay_order_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/payment_method.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/presentation/bloc/card/card_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/cards/cards_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OptionsPayShoppingCartScreen extends StatefulWidget {
  final List<ProductEntity> products;
  final List<OrderEntity> services;
  final double total;

  const OptionsPayShoppingCartScreen({
    super.key,
    required this.products,
    required this.services,
    required this.total,
  });

  @override
  State<OptionsPayShoppingCartScreen> createState() =>
      _OptionsPayShoppingCartScreenState();
}

class _OptionsPayShoppingCartScreenState
    extends State<OptionsPayShoppingCartScreen> {
  String _metodo = "EFECTIVO";
  List<CardEntity> cards = [];
  CardEntity? selectedCard;

  // Flags para controlar cuando ambos pagos hayan finalizado
  bool _productsPaid = false;
  bool _servicesPaid = false;

  @override
  void initState() {
    super.initState();
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      context.read<CardsBloc>().add(GetCardsEvent(userId: userState.user.id));
    }
  }

  void _checkIfAllPaid() {
    if (_productsPaid && _servicesPaid) {
      final userState = sl<UserBloc>().state;
      if (userState is UserAuthenticated) {
        context.read<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
      }
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: "Compra realizada con éxito"),
      );
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    UserEntity? userEntity;

    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      userEntity = userState.user;
    }

    return BlocBuilder<CardsBloc, CardsState>(builder: (context, state) {
      if (state is CardsLoaded) {
        cards = state.cards;
      }

      return MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartLoaded) {
                setState(() {
                  _productsPaid = true;
                });
                _checkIfAllPaid();
              } else if (state is CartError) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: "Error al pagar productos"),
                );
              }
            },
          ),
          BlocListener<PayOrderBloc, PayOrderState>(
            listener: (context, state) {
              if (state is PayOrderLoaded) {
                setState(() {
                  _servicesPaid = true;
                });
                _checkIfAllPaid();
              } else if (state is PayOrderError) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: "Error al pagar servicios"),
                );
              }
            },
          ),
          BlocListener<CardBloc, CardState>(
            listener: (context, state) {
              if (state is CardLoaded) {
                setState(() {
                  _servicesPaid = true;
                });
                _checkIfAllPaid();
              } else if (state is CardError) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: "Error al pagar con tarjeta"),
                );
              }
            },
          ),
        ],
        child: CustomScaffold(
          leading: ArrowBack(),
          text: texts.pay_products,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Información de facturación
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(texts.billing_information),
                        const Spacer(),
                        Text(
                          texts.change,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: const Color(0xFFF44565),
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFFF44565),
                                  ),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CustomLocalSvgImage(
                          assetPath: 'assets/svg/factura.svg',
                          height: 64,
                          color: const Color(0xFFF44565),
                        ),
                        const SizedBox(width: 16),
                        if (userEntity != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userEntity.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(userEntity.dni)
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Mostrar total a pagar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      texts.total,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$${widget.total.toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Selección método de pago
              PaymentMethod(
                metodo: _metodo,
                onChangeMetodo: (value) => setState(() => _metodo = value),
                cards: cards,
                selectedCard: selectedCard,
                onCardSelected: (card) {
                  setState(() {
                    selectedCard = card;
                  });
                },
              ),

              const SizedBox(height: 24),

              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final isLoading = state is CartLoading;
                  // También podrías verificar estados de PayOrderBloc o CardBloc para mostrar carga
                  return FilledButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            setState(() {
                              _productsPaid = false;
                              _servicesPaid = false;
                            });

                            context.read<CartBloc>().add(
                                  AddToCart(
                                    products: widget.products,
                                  ),
                                );

                            if (_metodo == "EFECTIVO") {
                              context.read<PayOrderBloc>().add(
                                    PagarVariasOrdenesEvent(
                                      orderIds: widget.services,
                                      paymentType: stringToPaymentType(_metodo),
                                    ),
                                  );
                            } else {
                              if (selectedCard == null) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                      message: "Seleccione una tarjeta"),
                                );
                                return;
                              }

                              context.read<CardBloc>().add(
                                    DebitCardsEvent(
                                      cardId: selectedCard!.cardId,
                                      orders: widget.services,
                                    ),
                                  );
                            }
                          },
                    child: (_metodo == "EFECTIVO")
                        ? Text(texts.confirm_purchase)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(texts.pay_now)],
                          ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
