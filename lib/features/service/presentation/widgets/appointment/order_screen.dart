import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_products_chose.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_receipt.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_services_chosen.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/pay_order_button.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/payment_method.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/total_order_container.dart';
import 'package:antonella/features/user/domain/entities/card_entity.dart';
import 'package:antonella/features/user/presentation/bloc/cards/cards_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  final OrderEntity orderEntity;
  final bool canPay;
  final bool canViewReceipt;
  const OrderScreen(
      {super.key,
      required this.orderEntity,
      this.canPay = true,
      this.canViewReceipt = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _metodo = "EFECTIVO";
  CardEntity? _selectedCard;

  List<CardEntity> cards = [];
  @override
  void initState() {
    super.initState();
    final stateUser = sl<UserBloc>().state;
    if (stateUser is UserAuthenticated) {
      context.read<CardsBloc>().add(GetCardsEvent(userId: stateUser.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientConfirmed =
        widget.orderEntity.clientStatus == ClientStatus.confirmado;
    return BlocBuilder<CardsBloc, CardsState>(builder: (context, state) {
      if (state is CardsLoaded) {
        cards = state.cards;
      }
      return CustomScaffold(
          leading: ArrowBack(),
          text: clientConfirmed ? 'Orden Confirmada' : 'Orden',
          paddingScroll: EdgeInsets.all(16),
          child: Column(children: [
            InfoServicesChosen(orderEntity: widget.orderEntity),
            const SizedBox(height: 16),
            InfoProductsChosen(orderEntity: widget.orderEntity),
            if (!clientConfirmed && widget.canPay)
              Column(children: [
                const SizedBox(height: 16),
                InfoReceipt(orderEntity: widget.orderEntity),
                const SizedBox(height: 16),
                PaymentMethod(
                  metodo: _metodo,
                  onChangeMetodo: (value) {
                    setState(() {
                      _metodo = value;
                      if (_metodo != "TARJETA") _selectedCard = null;
                    });
                  },
                  cards: cards,
                  selectedCard: _selectedCard,
                  onCardSelected: (card) {
                    setState(() {
                      _selectedCard = card;
                    });
                  }
                ),
                const SizedBox(height: 16),
                TotalOrderContainer(orderEntity: widget.orderEntity),
                const SizedBox(height: 16),
                PayOrderButton(
                    metodo: _metodo,
                    orderEntity: widget.orderEntity,
                    selectedCard: _selectedCard)
              ]),
            const SizedBox(height: 16),
            if (widget.canViewReceipt)
              InfoReceipt(
                  orderEntity: widget.orderEntity,
                  isPaid: true,
                  metodo: widget.orderEntity.paymentType.name.toUpperCase())
          ]));
    });
  }
}
