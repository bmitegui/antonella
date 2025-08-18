import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/get_employee_busy_schedule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_schedule_event.dart';
part 'employee_schedule_state.dart';

class EmployeeScheduleBloc
    extends Bloc<EmployeeScheduleEvent, EmployeeScheduleState> {
  final GetEmployeeBusyScheduleInfoUseCase getEmployeeBusyScheduleInfoUseCase;

  EmployeeScheduleBloc({required this.getEmployeeBusyScheduleInfoUseCase})
      : super(EmployeeScheduleInitial()) {
    on<GetEmployeeScheduleEvent>(_onGetEmployeeScheduleEventRequest);
  }

  Future<void> _onGetEmployeeScheduleEventRequest(
      GetEmployeeScheduleEvent event,
      Emitter<EmployeeScheduleState> emit) async {
    emit(EmployeeScheduleLoading());
    final failureOrEmployeeSchedule = await getEmployeeBusyScheduleInfoUseCase(
        GetEmployeeBusyScheduleParams(employeeId: event.employeeId));

    failureOrEmployeeSchedule.fold((failure) {
      emit(EmployeeScheduleError(failure: failure));
    }, (dates) {
      emit(EmployeeScheduleLoaded(dates: dates));
    });
  }
}
