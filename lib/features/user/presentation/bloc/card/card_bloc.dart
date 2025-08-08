import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/usecases/add_card_use_case.dart';
import 'package:antonella/features/user/domain/usecases/debit_card_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final AddCardUseCase addCardUseCase;
  final DebitCardUseCase debitCardUseCase;

  CardBloc({required this.addCardUseCase, required this.debitCardUseCase})
      : super(CardInitial()) {
    on<AddCardEvent>(_onAddCardEventRequest);
    on<DebitCardEvent>(_onDebitCardEventRequest);
  }

  Future<void> _onDebitCardEventRequest(
      DebitCardEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    final failureOrEmployees = await debitCardUseCase(DebitCardParams(
        cardId: event.cardId,
        orderId: event.orderId,
        taxableAmount: event.taxableAmount));

    failureOrEmployees.fold((failure) {
      emit(CardError(failure: failure));
    }, (data) {
      emit(CardLoaded());
    });
  }

  Future<void> _onAddCardEventRequest(
      AddCardEvent event, Emitter<CardState> emit) async {
    emit(AddCardLoading());
    final failureOrEmployees = await addCardUseCase(AddCardParams(
        userId: event.userId,
        number: event.number,
        expiryMonth: event.expiryMonth,
        expiryYear: event.expiryYear,
        cvc: event.cvc));

    failureOrEmployees.fold((failure) {
      emit(CardError(failure: failure));
    }, (data) {
      emit(CardLoaded());
    });
  }
}
