part of 'promotion_bloc.dart';

sealed class PromotionState {
  const PromotionState();
}

final class PromotionInitial extends PromotionState {}

final class PromotionLoading extends PromotionState {}

final class PromotionLoaded extends PromotionState {
  final List<PromotionEntity> listPromotions;
  PromotionLoaded(
      {required this.listPromotions});
}

final class PromotionError extends PromotionState {
  final Failure failure;
  PromotionError({required this.failure});
}
