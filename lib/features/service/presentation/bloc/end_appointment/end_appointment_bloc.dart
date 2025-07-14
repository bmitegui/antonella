import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/usecases/end_appointment_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'end_appointment_event.dart';
part 'end_appointment_state.dart';

class EndAppointmentBloc
    extends Bloc<EndAppointmentEvent, EndAppointmentState> {
  final EndAppointmentUseCase endAppointmentUseCase;

  EndAppointmentBloc({required this.endAppointmentUseCase})
      : super(EndAppointmentInitial()) {
    on<TerminarCitaEvent>(_onTerminarCitaEventRequest);
  }

  Future<void> _onTerminarCitaEventRequest(
      TerminarCitaEvent event, Emitter<EndAppointmentState> emit) async {
    emit(EndAppointmentLoading());
    final failureOrSuccess = await endAppointmentUseCase(EndAppointmentParams(
        orderId: event.orderId, appointmentId: event.appointmentId));
    failureOrSuccess.fold((failure) async {
      emit(EndAppointmentError(failure: failure));
    }, (data) async {
      emit(EndAppointmentLoaded());
    });
  }
}
