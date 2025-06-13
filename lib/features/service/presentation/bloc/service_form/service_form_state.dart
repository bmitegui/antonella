part of 'service_form_bloc.dart';

sealed class ServiceFormState {
  const ServiceFormState();
}

final class ServiceFormInitial extends ServiceFormState {}

final class ServiceFormLoading extends ServiceFormState {}

final class ServiceFormLoaded extends ServiceFormState {
  final ServiceEntity service;
  ServiceFormLoaded({required this.service});
}

final class ServiceFormError extends ServiceFormState {
  final String message;
  ServiceFormError({required this.message});
}
