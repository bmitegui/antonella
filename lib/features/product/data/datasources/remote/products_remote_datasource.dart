import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:dio/dio.dart';

abstract class ProductsRemoteDataSource {
  Future<ListProductsModel> getProducts();
}

class ProductsRemoteDataSourceImpl
    with RemoteRequestHelper
    implements ProductsRemoteDataSource {
  final Dio client;
  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future<ListProductsModel> getProducts() async {
    return await handleRequest(
        request: () => client.get(Environment.product, options: defaultOptions),
        onSuccess: (data) => ListProductsModel.fromJson({'data': data}));
  }
}
