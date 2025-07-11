import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/usecases/get_promotions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final GetPromotionsUseCase getPromotionsUseCase;

  PromotionBloc({required this.getPromotionsUseCase}) : super(PromotionInitial()) {
    on<GetPromotionsEvent>(_onGetPromotionsEventRequest);
  }

  Future<void> _onGetPromotionsEventRequest(
      GetPromotionsEvent event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    final failureOrSuccess = await getPromotionsUseCase(NoParams());
    failureOrSuccess.fold((failure) async {
      emit(PromotionError(failure: failure));
    }, (listPromotions) async {
        emit(PromotionLoaded(listPromotions: listPromotions));
    });
  }

}
