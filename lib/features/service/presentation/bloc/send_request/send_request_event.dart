part of 'send_request_bloc.dart';

sealed class SendRequestEvent {
  const SendRequestEvent();
}

final class SendRequestInitialEvent extends SendRequestEvent {}

final class EnviarPeticionEvent extends SendRequestEvent {
  final String clientId;
  final String day;
  final String start;
  final Map<String, String> employeeIds;
  final List<ServiceEntity> services;
  final List<ProductEntity> products;

  EnviarPeticionEvent(
      {required this.clientId,
      required this.day,
      required this.start,
      required this.employeeIds,
      required this.services,
      required this.products});
}
