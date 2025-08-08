import 'package:antonella/core/error/failures.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/usecases/get_promotions_related_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promotion_cart_event.dart';
part 'promotion_cart_state.dart';

class PromotionCartBloc extends Bloc<PromotionCartEvent, PromotionCartState> {
  final GetPromotionsRelatedUseCase getPromotionsRelated;

  PromotionCartBloc({required this.getPromotionsRelated})
      : super(PromotionCartLoaded(cartPromotions: [])) {
    on<AddPromotionToCartEvent>(_onAddPromotionEvent);
    on<GetPromotionRelatedEvent>(_onGetPromotionRelatedEventRequest);
  }

  Future<void> _onGetPromotionRelatedEventRequest(
      GetPromotionRelatedEvent event, Emitter<PromotionCartState> emit) async {
    emit(PromotionLoading());
    final failureOrSuccess = await getPromotionsRelated(
        GetPromotionsRelatedParams(
            servicesId: event.servicesId, productsId: event.productsId));
    failureOrSuccess.fold((failure) async {
      emit(PromotionError(failure: failure));
    }, (listPromotions) async {
      emit(PromotionCartLoaded(cartPromotions: listPromotions));
    });
  }

  Future<void> _onAddPromotionEvent(
      AddPromotionToCartEvent event, Emitter<PromotionCartState> emit) async {
    final currentState = state;
    if (currentState is PromotionCartLoaded) {
      final updatedPromotions =
          List<PromotionEntity>.from(currentState.cartPromotions);

      // Verifica si ya fue añadida
      if (!updatedPromotions.any((p) => p.id == event.promotionEntity.id)) {
        updatedPromotions.add(event.promotionEntity);
      }

      emit(PromotionCartLoaded(cartPromotions: updatedPromotions));
    } else {
      emit(PromotionCartLoaded(cartPromotions: [event.promotionEntity]));
    }
  }
}
