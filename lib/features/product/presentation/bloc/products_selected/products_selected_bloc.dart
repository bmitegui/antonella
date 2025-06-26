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
      final List<ProductEntity> original = currentState.products;
      final List<ProductEntity> updatedProducts = [];

      bool inserted = false;
      int insertIndex = -1;

      for (int i = 0; i < original.length; i++) {
        final product = original[i];

        if (product.id == event.product.id) {
          // Solo una vez guarda el índice de inserción
          if (!inserted) {
            insertIndex = updatedProducts.length;
            inserted = true;
          }
          // Omitimos esta instancia (porque se reemplazará)
          continue;
        }

        updatedProducts.add(product);
      }

      // Generar la nueva cantidad de productos
      final newItems = List.generate(event.cant, (_) => event.product);

      if (inserted) {
        // Si ya existía, insertamos en la posición original
        updatedProducts.insertAll(insertIndex, newItems);
      } else {
        // Si no existía, lo agregamos al final
        updatedProducts.addAll(newItems);
      }

      emit(ProductsSelectedLoading());
      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  Future<void> _onUpdateProductQuantityEventRequest(
    UpdateProductQuantityEvent event,
    Emitter<ProductsSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductsSelectedLoaded) {
      final List<ProductEntity> updatedProducts = [];

      bool inserted = false;

      for (int i = 0; i < currentState.products.length; i++) {
        final product = currentState.products[i];

        if (product.id == event.product.id) {
          // Insertar la nueva cantidad una sola vez en la primera coincidencia
          if (!inserted) {
            updatedProducts.addAll(
              List.generate(event.newQuantity, (_) => event.product),
            );
            inserted = true;
          }
          // Omitir esta instancia
          //continue;
        }

        // Mantener el resto de productos
        updatedProducts.add(product);
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
