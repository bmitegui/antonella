import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ListProductsModel>> getProducts();
}
