part of 'card_bloc.dart';

sealed class CardEvent {
  const CardEvent();
}

final class CardInitialEvent extends CardEvent {}

final class AddCardEvent extends CardEvent {
  final String userId;
  final String number;
  final int expiryMonth;
  final int expiryYear;
  final String cvc;

  AddCardEvent(
      {required this.userId,
      required this.number,
      required this.expiryMonth,
      required this.expiryYear,
      required this.cvc});
}

final class DebitCardEvent extends CardEvent {
  final String cardId;
  final String orderId;
  final double taxableAmount;

  DebitCardEvent(
      {required this.cardId,
      required this.orderId,
      required this.taxableAmount});
}
