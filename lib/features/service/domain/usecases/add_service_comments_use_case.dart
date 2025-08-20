import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class AddServiceCommentUseCase
    implements UseCase<void, AddServiceCommentParams> {
  final ServiceRepository serviceRepository;
  AddServiceCommentUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, void>> call(
      AddServiceCommentParams addServiceCommentParams) async {
    return await serviceRepository.addServiceComment(
        serviceId: addServiceCommentParams.serviceId,
        comment: addServiceCommentParams.comment,
        stars: addServiceCommentParams.stars);
  }
}

class AddServiceCommentParams {
  final String serviceId;
  final String comment;
  final int stars;
  AddServiceCommentParams(
      {required this.serviceId, required this.comment, required this.stars});
}
