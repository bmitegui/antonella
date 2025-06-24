import 'package:antonella/core/error/failures.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_selected_event.dart';
part 'products_selected_state.dart';

class ProductsSelectedBloc
    extends Bloc<ProductsSelectedEvent, ProductsSelectedState> {
  ProductsSelectedBloc() : super(ProductsSelectedLoaded(products: [])) {
    on<AddProductEvent>(_onAddProductEventRequest);
    on<DeleteProductEvent>(_onDeleteProductEventRequest);
    on<UpdateProductQuantityEvent>(_onUpdateProductQuantityEventRequest);
    on<ClearProductSelectedEvent>(_onClearProductsSelectedEventRequest);
  }
  Future<void> _onClearProductsSelectedEventRequest(
      ClearProductSelectedEvent event,
      Emitter<ProductsSelectedState> emit) async {
    emit(ProductsSelectedLoading());
    emit(ProductsSelectedLoaded(products: []));
  }

  Future<void> _onAddProductEventRequest(
    AddProductEvent event,
    Emitter<ProductsSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductsSelectedLoaded) {
      final products = List<ProductEntity>.from(currentState.products);
      for (var i = 0; i < event.cant; i++) {
        products.add(event.product);
      }

      emit(ProductsSelectedLoading());
      emit(currentState.copyWith(products: products));
    }
  }

  Future<void> _onUpdateProductQuantityEventRequest(
    UpdateProductQuantityEvent event,
    Emitter<ProductsSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductsSelectedLoaded) {
      final updatedProducts = List<ProductEntity>.from(currentState.products);

      updatedProducts.removeWhere((p) => p.id == event.product.id);

      for (int i = 0; i < event.newQuantity; i++) {
        updatedProducts.add(event.product);
      }

      emit(ProductsSelectedLoading());
      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  Future<void> _onDeleteProductEventRequest(
      DeleteProductEvent event, Emitter<ProductsSelectedState> emit) async {
    final currentState = state;
    if (currentState is ProductsSelectedLoaded) {
      final products = currentState.products;
      products.removeWhere((service) => service.id == event.product.id);
      emit(ProductsSelectedLoading());
      emit(currentState.copyWith(products: products));
    }
  }
}
