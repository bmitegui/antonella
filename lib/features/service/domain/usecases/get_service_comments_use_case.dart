import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetServiceCommentsUseCase
    implements UseCase<List<CommentEntity>, GetServiceCommentsParams> {
  final ServiceRepository serviceRepository;
  GetServiceCommentsUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
      GetServiceCommentsParams getServiceCommentsParams) async {
    return await serviceRepository.getServiceComments(
        serviceId: getServiceCommentsParams.serviceId);
  }
}

class GetServiceCommentsParams {
  final String serviceId;
  GetServiceCommentsParams({required this.serviceId});
}
