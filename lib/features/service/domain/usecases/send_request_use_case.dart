import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class SendRequestUseCase implements UseCase<void, SendRequestParams> {
  final ServiceRepository serviceRepository;
  SendRequestUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, void>> call(
      SendRequestParams sendRequestParams) async {
    return await serviceRepository.sendRequest(
        clientId: sendRequestParams.clientId,
        day: sendRequestParams.day,
        start: sendRequestParams.start,
        employeeIds: sendRequestParams.employeeIds,
        services: sendRequestParams.services);
  }
}

class SendRequestParams {
  final String clientId;
  final String day;
  final String start;
  final Map<String, String> employeeIds;
  final List<ServiceEntity> services;

  SendRequestParams(
      {required this.clientId,
      required this.day,
      required this.start,
      required this.employeeIds,
      required this.services});
}
