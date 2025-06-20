import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/exceptions.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:dio/dio.dart';

abstract class ProductsRemoteDataSource {
  Future<ListProductsModel> getProducts();

  Future<void> sendProducts({required List<ProductEntity> products});
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
  
  @override
  Future<void> sendProducts({required List<ProductEntity> products}) async{
    return await handleRequest(
        request: () => client.post(Environment.orderProductItem, options: defaultOptions,
        data: {}),
        onSuccess: (_) => {});
  }

   @override
  Future<void> sendRequest(
      {required String clientId,
      required List<ProductEntity> products}) async {
    try {
      final orderId = await createOrder(clientId: clientId);
      for (ProductEntity product in products) {
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<String> createOrder({required String clientId}) async {
    final data = {
      "client_id": clientId,
      "status": {
        "payment_status": "PENDIENTE",
        "payment_type": "EFECTIVO",
        "progress_status": "PENDIENTE",
        "status": "NO_CONFIRMADO"
      }
    };
    return await handleRequest(
        request: () =>
            client.post(Environment.order, data: data, options: defaultOptions),
        onSuccess: (data) => data['id']);
  }
}
