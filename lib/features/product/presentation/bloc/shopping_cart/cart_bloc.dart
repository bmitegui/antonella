import 'package:antonella/features/product/domain/entities/cart_item.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/domain/usecases/get_cart_items_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;

  CartBloc({required this.getCartItemsUseCase}) : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final failureOrSuccess = await getCartItemsUseCase(SendRequestParams(
        products: event.products));
    failureOrSuccess.fold((failure) async {
      emit(SendRequestError(message: _mapFailureToMessage(failure)));
    }, (data) async {
      emit(SendRequestLoaded());
    });
  }
}

class SendRequestBloc extends Bloc<SendRequestEvent, SendRequestState> {
  final SendRequestUseCase getSendRequestsUseCase;

  SendRequestBloc({required this.getSendRequestsUseCase})
      : super(SendRequestInitial()) {
    on<EnviarPeticionEvent>(_onEnviarPeticionEventRequest);
  }

  Future<void> _onEnviarPeticionEventRequest(
      EnviarPeticionEvent event, Emitter<SendRequestState> emit) async {
    emit(SendRequestLoading());
    final failureOrSuccess = await getSendRequestsUseCase(SendRequestParams(
        clientId: event.clientId,
        day: event.day,
        start: event.start,
        employeeId: event.employeeId,
        services: event.services));
    failureOrSuccess.fold((failure) async {
      emit(SendRequestError(message: _mapFailureToMessage(failure)));
    }, (data) async {
      emit(SendRequestLoaded());
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return unexpectedError;
    }
  }
}


