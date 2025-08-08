import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';

class CardModel extends CardEntity {
  const CardModel(
      {required super.userId,
      required super.cardId,
      required super.hideNumber,
      required super.type});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        userId: json['user_id'],
        cardId: json['card_id'],
        hideNumber: json['number'],
        type: stringToCardType(json['type']));
  }
}
