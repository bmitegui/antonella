import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ListServicesModel>> getServices(
      {required String? filter});

  Future<Either<Failure, List<ServiceFormModel>>> getListServiceForm(
      {required String category});
}
