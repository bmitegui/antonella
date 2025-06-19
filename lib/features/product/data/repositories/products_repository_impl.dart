import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/utils/repository_impl_util.dart';
import 'package:antonella/features/product/data/datasources/remote/products_remote_datasource.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:antonella/features/product/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final NetworkInfo networkInfo;
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl(
      {required this.networkInfo, required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, ListProductsModel>> getProducts() async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final listProducts = await productsRemoteDataSource.getProducts();
          return listProducts;
        });
  }
}
