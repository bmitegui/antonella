import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/data/models/lis_product_model.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
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
  Future<void> sendProducts({required List<ProductEntity> products}) async {
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      final orderId = await createOrder(clientId: userState.user.id);

      final result = groupProducts(products, orderId);
      for (Map<String, dynamic> data in result) {
        await handleRequest(
            request: () => client.post(Environment.orderProductItem,
                options: defaultOptions, data: data),
            onSuccess: (_) => {});
      }
    }
  }

  Future<String> createOrder({required String clientId}) async {
    final data = {
      "client_id": clientId,
      "status": {
        "status": "CONFIRMADO",
        "progress_status": "EN_PROGRESO",
        "payment_status": "PAGADO",
        "payment_type": "EFECTIVO",
        "client_confirmed": "CONFIRMADO"
      }
    };
    return await handleRequest(
        request: () =>
            client.post(Environment.order, data: data, options: defaultOptions),
        onSuccess: (data) => data['id']);
  }
}
