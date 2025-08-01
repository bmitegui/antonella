import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'employee_info_event.dart';
part 'employee_info_state.dart';

class EmployeeInfoBloc extends Bloc<EmployeeInfoEvent, EmployeeInfoState> {
  final GetEmployeeInfoUseCase getEmployeeInfoUseCase;

  EmployeeInfoBloc({required this.getEmployeeInfoUseCase})
      : super(EmployeeInfoInitial()) {
    on<GetEmployeeInfoEvent>(_onGetEmployeeInfoEventRequest);
  }

  Future<void> _onGetEmployeeInfoEventRequest(
      GetEmployeeInfoEvent event, Emitter<EmployeeInfoState> emit) async {
    emit(EmployeeInfoLoading());
    final failureOrSuccess = await getEmployeeInfoUseCase(GetEmployeeInfoParams(
        employeeId: event.employeeId,
        startDate: event.startDate,
        endDate: event.endDate));
    failureOrSuccess.fold((failure) {
      emit(EmployeeInfoError(failure: failure));
    }, (employeeEntity) async {
      emit(EmployeeInfoLoaded(employeeInfoEntity: employeeEntity));
    });
  }
}
