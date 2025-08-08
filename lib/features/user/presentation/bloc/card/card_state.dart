part of 'card_bloc.dart';

sealed class CardState {
  const CardState();
}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class AddCardLoading extends CardState {}

final class CardLoaded extends CardState {}

final class CardError extends CardState {
  final Failure failure;
  CardError({required this.failure});
}
