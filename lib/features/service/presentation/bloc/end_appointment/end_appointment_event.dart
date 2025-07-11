part of 'end_appointment_bloc.dart';

sealed class EndAppointmentEvent {
  const EndAppointmentEvent();
}

final class EndAppointmentInitialEvent extends EndAppointmentEvent {}

final class TerminarCitaEvent extends EndAppointmentEvent {
  final String orderId;
  final String appointmentId;
  TerminarCitaEvent({required this.orderId, required this.appointmentId});
}
