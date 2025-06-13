import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ListServicesModel>> getServices();
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId});
  Future<Either<Failure, void>> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required ServiceEntity service});
}
