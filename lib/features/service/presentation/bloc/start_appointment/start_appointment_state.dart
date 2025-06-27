part of 'start_appointment_bloc.dart';

sealed class StartAppointmentState {
  const StartAppointmentState();
}

final class StartAppointmentInitial extends StartAppointmentState {}

final class StartAppointmentLoading extends StartAppointmentState {}

final class StartAppointmentLoaded extends StartAppointmentState {}

final class StartAppointmentError extends StartAppointmentState {
  final Failure failure;
  StartAppointmentError({required this.failure});
}
