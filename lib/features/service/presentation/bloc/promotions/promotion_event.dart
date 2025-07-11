part of 'promotion_bloc.dart';

sealed class PromotionEvent {
  const PromotionEvent();
}

final class PromotionInitialEvent extends PromotionEvent {}

final class GetPromotionsEvent extends PromotionEvent {
  GetPromotionsEvent();
}

final class AddPromotionEvent extends PromotionEvent {
  final PromotionEntity promotionEntity;

  AddPromotionEvent({required this.promotionEntity});
}
