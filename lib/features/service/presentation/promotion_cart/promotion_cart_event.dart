part of 'promotion_cart_bloc.dart';

sealed class PromotionCartEvent {
  const PromotionCartEvent();
}

final class PromotionInitialEvent extends PromotionCartEvent {}

class AddPromotionToCartEvent extends PromotionCartEvent {
  final PromotionEntity promotionEntity;

  AddPromotionToCartEvent({required this.promotionEntity});
}

