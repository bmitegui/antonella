import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/utils/repository_impl_util.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final NetworkInfo networkInfo;
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepositoryImpl(
      {required this.networkInfo, required this.serviceRemoteDataSource});

  @override
  Future<Either<Failure, ListServicesModel>> getServices() async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final remoteServices = await serviceRemoteDataSource.getServices();
          return remoteServices;
        });
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final remoteServiceComments = await serviceRemoteDataSource
              .getServiceComments(serviceId: serviceId);
          return remoteServiceComments;
        });
  }

  @override
  Future<Either<Failure, void>> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required List<ServiceEntity> services}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await serviceRemoteDataSource.sendRequest(
              clientId: clientId,
              day: day,
              start: start,
              employeeId: employeeId,
              services: services);
        });
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders(
      {required String id}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final orders = await serviceRemoteDataSource.getOrders(id: id);
          return orders;
        });
  }

  @override
  Future<Either<Failure, void>> payOrder(
      {required PaymentType paymentType}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await serviceRemoteDataSource.payOrder(paymentType: paymentType);
        });
  }
}
