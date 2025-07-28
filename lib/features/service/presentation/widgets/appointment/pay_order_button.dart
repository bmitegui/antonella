import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/bloc/pay_order/pay_order_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayOrderButton extends StatelessWidget {
  final String metodo;
  final OrderEntity orderEntity;
  const PayOrderButton(
      {super.key, required this.metodo, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocConsumer<PayOrderBloc, PayOrderState>(
        listener: (context, state) {
      if (state is PayOrderLoaded) {
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.success(message: texts.appointment_confirmed));
        final userState = sl<UserBloc>().state;
        if (userState is UserAuthenticated) {
          sl<OrdersBloc>().add(GetOrdersEvent(id: userState.user.id));
        }
        Navigator.pop(context);
      } else if (state is PayOrderError) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
                message: mapFailureToMessage(
                    context: context, failure: state.failure)));
      }
    }, builder: (context, state) {
      return (state is PayOrderLoading)
          ? CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF44565))),
                  onPressed: () async => context.read<PayOrderBloc>().add(
                      PagarOrdenEvent(
                          orderId: orderEntity.id,
                          paymentType: stringToPaymentType(metodo))),
                  child: (metodo == "EFECTIVO")
                      ? Text(texts.confirm_appointment)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(texts.pay_now),
                              Text(
                                  '\$${getTotalBasePrice(orderEntity.appointments)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.white))
                            ])));
    });
  }
}
