part of 'cards_bloc.dart';

sealed class CardsEvent {
  const CardsEvent();
}

final class CardsInitialEvent extends CardsEvent {}

final class GetCardsEvent extends CardsEvent {
  final String userId;
  GetCardsEvent({required this.userId});
}