import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ListServicesModel>> getServices();
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId});
  Future<Either<Failure, void>> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required Map<String, String> employeeIds,
      required List<ServiceEntity> services});
  Future<Either<Failure, List<OrderModel>>> getOrders({required String id});
  Future<Either<Failure, void>> payOrder(
      {required String orderId, required PaymentType paymentType});
  Future<Either<Failure, List<QuestionModel>>> getFormDone(
      {required String clientId, required String serviceItemId});
  Future<Either<Failure, void>> startAppointment(
      {required String orderId, required String appointmentId});
  Future<Either<Failure, void>> endAppointment(
      {required String orderId, required String appointmentId});
  Future<Either<Failure, List<PromotionEntity>>> getPromotions();
}
