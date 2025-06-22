import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/failures.dart';
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
    final failureOrSuccess =
        await getCartItemsUseCase(SendRequestParams(products: event.products));
    failureOrSuccess.fold((failure) async {
      emit(CartError(message: _mapFailureToMessage(failure)));
    }, (data) async {
      emit(CartLoaded());
    });
  }
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
