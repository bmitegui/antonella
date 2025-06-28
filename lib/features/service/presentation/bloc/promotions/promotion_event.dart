part of 'promotion_bloc.dart';

sealed class PromotionEvent {
  const PromotionEvent();
}

final class PromotionInitialEvent extends PromotionEvent {}

final class GetPromotionsEvent extends PromotionEvent {
  final List<PromotionEntity> listPromotions;

  GetPromotionsEvent({required this.listPromotions});
  
}
