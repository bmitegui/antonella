import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductsRepository productsRepository;
  GetProductsUseCase({required this.productsRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams noParams) async {
    return await productsRepository.getProducts();
  }
}
