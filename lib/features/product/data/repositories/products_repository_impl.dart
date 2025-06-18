import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/features/product/data/datasources/remote/products_remote_datasource.dart';
import 'package:antonella/features/product/data/models/product_model.dart';
import 'package:antonella/features/product/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final NetworkInfo networkInfo;
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl(
      {required this.networkInfo, required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final listProducts = await productsRemoteDataSource.getProducts();
        return Right(listProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(ServerFailure(message: networkConnectionError));
    }
  }
}
