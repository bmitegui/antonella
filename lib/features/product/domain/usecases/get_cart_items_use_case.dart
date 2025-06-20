import 'package:antonella/core/error/failures.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartItemsUseCase implements UseCase<void, SendRequestParams> {
  final ProductsRepository productRepository;
  GetCartItemsUseCase({required this.productRepository});

  @override
  Future<Either<Failure, void>> call(
      SendRequestParams sendRequestParams) async {
    return await productRepository.sendProducts(products: sendRequestParams.products);
  }

}

class SendRequestParams {
  final List<ProductEntity> products;

  SendRequestParams(
      {required this.products});
}