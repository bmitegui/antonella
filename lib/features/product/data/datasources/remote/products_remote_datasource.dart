import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio client;
  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final result = await client.get(Environment.product,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        final data = result.data['data'] as List;
        return data
            .map<ProductModel>(
                (productData) => ProductModel.fromJson(productData))
            .toList();
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
