import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/entities/card_entity.dart';
import 'package:antonella/features/user/domain/usecases/get_cards_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final GetCardsUseCase getCardsUseCase;

  CardsBloc({required this.getCardsUseCase}) : super(CardsInitial()) {
    on<GetCardsEvent>(_onGetCardsEventRequest);
  }

  Future<void> _onGetCardsEventRequest(
      GetCardsEvent event, Emitter<CardsState> emit) async {
    emit(CardsLoading());
    final failureOrEmployees =
        await getCardsUseCase(GetCardsParams(userId: event.userId));

    failureOrEmployees.fold((failure) {
      emit(CardsError(failure: failure));
    }, (cards) {
      emit(CardsLoaded(cards: cards));
    });
  }
}
