import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/pay_order/pay_order_bloc.dart';
import 'package:antonella/features/user/domain/entities/card_entity.dart';
import 'package:antonella/features/user/presentation/bloc/card/card_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayOrderButton extends StatefulWidget {
  final String metodo;
  final OrderEntity orderEntity;
  final CardEntity? selectedCard;

  const PayOrderButton({
    super.key,
    required this.metodo,
    required this.orderEntity,
    this.selectedCard,
  });

  @override
  State<PayOrderButton> createState() => _PayOrderButtonState();
}

class _PayOrderButtonState extends State<PayOrderButton> {
  bool _paymentCompleted = false;

  void _handlePaymentCompleted() {
    if (!_paymentCompleted) {
      setState(() => _paymentCompleted = true);

      final userState = sl<UserBloc>().state;
      if (userState is UserAuthenticated) {
        context.read<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
      }

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: "Pago realizado con éxito"),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final totals = calculateTotals(widget.orderEntity);

    return BlocConsumer<PayOrderBloc, PayOrderState>(
      listener: (context, state) {
        if (state is PayOrderLoaded) {
          _handlePaymentCompleted();
        } else if (state is PayOrderError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
                message: mapFailureToMessage(
                    context: context, failure: state.failure)),
          );
        }
      },
      builder: (context, statePay) {
        return BlocConsumer<CardBloc, CardState>(
          listener: (context, stateCard) {
            if (stateCard is CardLoaded) {
              _handlePaymentCompleted();
            } else if (stateCard is CardError) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                    message: mapFailureToMessage(
                        context: context, failure: stateCard.failure)),
              );
            }
          },
          builder: (context, stateCard) {
            bool isLoading =
                statePay is PayOrderLoading || stateCard is CardLoading;

            return SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFF44565)),
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        if (widget.metodo == "EFECTIVO") {
                          context.read<PayOrderBloc>().add(
                                PagarOrdenEvent(
                                  orderId: widget.orderEntity.id,
                                  paymentType:
                                      stringToPaymentType(widget.metodo),
                                ),
                              );
                        } else {
                          if (widget.selectedCard == null) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                  message: "Seleccione una tarjeta"),
                            );
                            return;
                          }

                          context.read<CardBloc>().add(
                                DebitCardEvent(
                                  cardId: widget.selectedCard!.cardId,
                                  orderId: widget.orderEntity.id,
                                  taxableAmount: totals['total']!,
                                ),
                              );
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : (widget.metodo == "EFECTIVO")
                        ? Text(texts.confirm_appointment)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(texts.pay_now),
                              Text(
                                '\$${totals['total']!.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
              ),
            );
          },
        );
      },
    );
  }
}
