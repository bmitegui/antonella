import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/data/models/question_model.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetFormDoneUseCase
    implements UseCase<List<QuestionModel>, GetFormDoneParams> {
  final ServiceRepository serviceRepository;
  GetFormDoneUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<QuestionModel>>> call(
      GetFormDoneParams getFormDoneParams) async {
    return await serviceRepository.getFormDone(
        clientId: getFormDoneParams.clientId,
        serviceItemId: getFormDoneParams.serviceItemId);
  }
}

class GetFormDoneParams {
  final String clientId;
  final String serviceItemId;
  GetFormDoneParams({required this.clientId, required this.serviceItemId});
}
