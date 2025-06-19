import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/employee_info_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeInfoUseCase
    implements UseCase<EmployeeInfoEntity, GetEmployeeInfoParams> {
  final UserRepository userRepository;
  GetEmployeeInfoUseCase({required this.userRepository});

  @override
  Future<Either<Failure, EmployeeInfoEntity>> call(
      GetEmployeeInfoParams getEmployeeInfoParams) async {
    return await userRepository.getEmployeeInfo(
        employeeId: getEmployeeInfoParams.employeeId,
        startDate: getEmployeeInfoParams.startDate,
        endDate: getEmployeeInfoParams.endDate);
  }
}

class GetEmployeeInfoParams {
  final String employeeId;
  final String startDate;
  final String endDate;

  GetEmployeeInfoParams(
      {required this.employeeId,
      required this.startDate,
      required this.endDate});
}
