import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetListServiceFormUseCase
    implements UseCase<void, GetListServiceFormParams> {
  final ServiceRepository serviceRepository;
  GetListServiceFormUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<ServiceFormEntity>>> call(
      GetListServiceFormParams getServiceFormParams) async {
    return await serviceRepository.getListServiceForm(
        category: getServiceFormParams.category);
  }
}

class GetListServiceFormParams {
  final String category;
  GetListServiceFormParams({required this.category});
}
