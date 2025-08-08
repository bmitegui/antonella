import 'package:equatable/equatable.dart';

enum CardType {
  visa,
  mastercard,
  americanExpress,
  diners,
  discover,
  maestro,
  credisensa,
  solidario,
  unionPay
}

class CardEntity extends Equatable {
  final String userId;
  final String cardId;
  final String hideNumber;
  final CardType type;

  const CardEntity(
      {required this.userId,
      required this.cardId,
      required this.hideNumber,
      required this.type});

  @override
  List<Object?> get props => [cardId];
}
