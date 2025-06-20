import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ListProductsModel>> getProducts();

  Future<Either<Failure, void>> sendProducts({required List<ProductEntity> products});
}
