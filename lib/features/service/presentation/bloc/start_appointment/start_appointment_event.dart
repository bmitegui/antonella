part of 'start_appointment_bloc.dart';

sealed class StartAppointmentEvent {
  const StartAppointmentEvent();
}

final class StartAppointmentInitialEvent extends StartAppointmentEvent {}

final class EmpezarCitaEvent extends StartAppointmentEvent {
  final String orderId;
  final String appointmentId;
  EmpezarCitaEvent({required this.orderId, required this.appointmentId});
}
