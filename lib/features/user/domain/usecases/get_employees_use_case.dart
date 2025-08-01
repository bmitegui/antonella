import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetEmployeesUseCase
    implements UseCase<List<UserEntity>, GetEmployeesParams> {
  final UserRepository userRepository;
  GetEmployeesUseCase({required this.userRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      GetEmployeesParams getEmployeesParams) async {
    return await userRepository.getEmployees(
        serviceType: getEmployeesParams.serviceType);
  }
}

class GetEmployeesParams {
  final ServiceType serviceType;
  GetEmployeesParams({required this.serviceType});
}
