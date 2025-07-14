import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/utils/repository_impl_util.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
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
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final remoteServices = await serviceRemoteDataSource.getServices();
          return remoteServices;
        });
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId}) async {
    return await handleNetworkCall(
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
    return await handleNetworkCall(
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
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final orders = await serviceRemoteDataSource.getOrders(id: id);
          return orders;
        });
  }

  @override
  Future<Either<Failure, void>> payOrder(
      {required String orderId, required PaymentType paymentType}) async {
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await serviceRemoteDataSource.payOrder(
              orderId: orderId, paymentType: paymentType);
        });
  }

  @override
  Future<Either<Failure, List<QuestionModel>>> getFormDone(
      {required String clientId, required String serviceItemId}) async {
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          return await serviceRemoteDataSource.getFormDone(
              clientId: clientId, serviceItemId: serviceItemId);
        });
  }

  @override
  Future<Either<Failure, void>> startAppointment(
      {required String orderId, required String appointmentId}) async {
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await serviceRemoteDataSource.startAppointment(
              orderId: orderId, appointmentId: appointmentId);
        });
  }
  
  @override
  Future<Either<Failure, List<PromotionEntity>>> getPromotions() async{
    return await handleNetworkCall( 
      networkInfo: networkInfo,
      operation: () async {
        return await serviceRemoteDataSource.getPromotions();
      }
    );
  }
  
  @override
  Future<Either<Failure, void>> endAppointment({required String orderId, required String appointmentId}) async{
    return await handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await serviceRemoteDataSource.endAppointment(
              orderId: orderId, appointmentId: appointmentId);
        });
  }
}
