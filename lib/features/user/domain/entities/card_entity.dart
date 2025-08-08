import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String userId;
  final String cardId;
  final String hideNumber;
  final String type;

  const CardEntity(
      {required this.userId,
      required this.cardId,
      required this.hideNumber,
      required this.type});

  @override
  List<Object?> get props => [cardId];
}
