import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetServicesUseCase implements UseCase<void, NoParams> {
  final ServiceRepository serviceRepository;
  GetServicesUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, ListServicesEntity>> call(
      NoParams noParams) async {
    return await serviceRepository.getServices();
  }
}