import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/schedule_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeBusyScheduleInfoUseCase
    implements UseCase<List<ScheduleEntity>, GetEmployeeBusyScheduleParams> {
  final UserRepository userRepository;
  GetEmployeeBusyScheduleInfoUseCase({required this.userRepository});

  @override
  Future<Either<Failure, List<ScheduleEntity>>> call(
      GetEmployeeBusyScheduleParams getEmployeeInfoParams) async {
    return await userRepository.getEmployeeBusySchedule(
        employeeId: getEmployeeInfoParams.employeeId);
  }
}

class GetEmployeeBusyScheduleParams {
  final String employeeId;
  GetEmployeeBusyScheduleParams({required this.employeeId});
}
