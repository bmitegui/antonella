import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ListServicesModel>> getServices(
      {required ServiceCategory? filter});

  Future<Either<Failure, List<ServiceFormModel>>> getListServiceForm(
      {required ServiceCategory category});
}
