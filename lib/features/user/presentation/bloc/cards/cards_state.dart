part of 'cards_bloc.dart';

sealed class CardsState {
  const CardsState();
}

final class CardsInitial extends CardsState {}

final class CardsLoading extends CardsState {}

final class CardsLoaded extends CardsState {
  final List<CardEntity> cards;
  CardsLoaded({required this.cards});

}

final class CardsError extends CardsState {
  final Failure failure;
  CardsError({required this.failure});
}
