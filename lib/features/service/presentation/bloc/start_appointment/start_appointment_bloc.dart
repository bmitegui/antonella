import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/usecases/start_appointment_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'start_appointment_event.dart';
part 'start_appointment_state.dart';

class StartAppointmentBloc
    extends Bloc<StartAppointmentEvent, StartAppointmentState> {
  final StartAppointmentUseCase startAppointmentUseCase;

  StartAppointmentBloc({required this.startAppointmentUseCase})
      : super(StartAppointmentInitial()) {
    on<EmpezarCitaEvent>(_onEmpezarCitaEventRequest);
  }

  Future<void> _onEmpezarCitaEventRequest(
      EmpezarCitaEvent event, Emitter<StartAppointmentState> emit) async {
    emit(StartAppointmentLoading());
    final failureOrSuccess = await startAppointmentUseCase(
        StartAppointmentParams(
            orderId: event.orderId, appointmentId: event.appointmentId));
    failureOrSuccess.fold((failure) async {
      emit(StartAppointmentError(failure: failure));
    }, (data) async {
      emit(StartAppointmentLoaded());
    });
  }
}
