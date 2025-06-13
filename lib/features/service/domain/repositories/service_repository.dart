import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ListServicesModel>> getServices();
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId});
}
