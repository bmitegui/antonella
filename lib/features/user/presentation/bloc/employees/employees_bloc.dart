import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/get_employees_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final GetEmployeesUseCase getEmployeesUseCase;

  EmployeesBloc({required this.getEmployeesUseCase})
      : super(EmployeesInitial()) {
    on<GetEmployeesEvent>(_onGetEmployeesEventRequest);
  }

  Future<void> _onGetEmployeesEventRequest(
      GetEmployeesEvent event, Emitter<EmployeesState> emit) async {
    emit(EmployeesLoading());
    final failureOrEmployees = await getEmployeesUseCase(
        GetEmployeesParams(serviceType: event.serviceType));

    failureOrEmployees.fold((failure) {
      emit(EmployeesError(failure: failure));
    }, (employees) {
      emit(EmployeesLoaded(listEmployees: employees));
    });
  }
}
