part of 'end_appointment_bloc.dart';

sealed class EndAppointmentState {
  const EndAppointmentState();
}

final class EndAppointmentInitial extends EndAppointmentState {}

final class EndAppointmentLoading extends EndAppointmentState {}

final class EndAppointmentLoaded extends EndAppointmentState {}

final class EndAppointmentError extends EndAppointmentState {
  final Failure failure;
  EndAppointmentError({required this.failure});
}
