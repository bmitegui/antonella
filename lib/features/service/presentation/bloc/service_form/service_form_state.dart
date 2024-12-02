part of 'service_form_bloc.dart';

sealed class ServiceFormState {
  const ServiceFormState();
}

final class ServiceFormInitial extends ServiceFormState {}

final class ServiceFormLoading extends ServiceFormState {}

final class ServiceFormLoaded extends ServiceFormState {
  final List<ServiceFormEntity> listServiceForms;
  ServiceFormLoaded({required this.listServiceForms});
}

final class ServiceFormError extends ServiceFormState {
  final String message;
  ServiceFormError({required this.message});
}
