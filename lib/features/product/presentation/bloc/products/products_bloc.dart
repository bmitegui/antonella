import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/domain/usecases/get_products_use_case.dart';
import 'package:antonella/features/product/presentation/list_products_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  ProductsBloc({required this.getProductsUseCase}) : super(ProductsInitial()) {
    on<GetProductsEvent>(_onGetProductsEventRequest);
  }

  Future<void> _onGetProductsEventRequest(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final failureOrSuccess = await getProductsUseCase(NoParams());
    failureOrSuccess.fold((failure) async {
      emit(ProductsError(failure: failure));
    }, (listProducts) async {
      if (event.productType != null && event.productType != ProductType.all) {
        final productFilter = listProducts.products
            .where((product) => product.type == event.productType)
            .toList();
        emit(ProductsLoaded(
            listProducts: listProducts.copyWith(products: productFilter),
            productType: event.productType!));
      } else {
        emit(ProductsLoaded(listProducts: listProducts));
      }
    });
  }
}
