import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/domain/usecases/send_request_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'send_request_event.dart';
part 'send_request_state.dart';

class SendRequestBloc extends Bloc<SendRequestEvent, SendRequestState> {
  final SendRequestUseCase getSendRequestsUseCase;

  SendRequestBloc({required this.getSendRequestsUseCase})
      : super(SendRequestInitial()) {
    on<EnviarPeticionEvent>(_onEnviarPeticionEventRequest);
  }

  Future<void> _onEnviarPeticionEventRequest(
      EnviarPeticionEvent event, Emitter<SendRequestState> emit) async {
    emit(SendRequestLoading());
    final failureOrSuccess = await getSendRequestsUseCase(SendRequestParams(
        clientId: event.clientId,
        day: event.day,
        start: event.start,
        employeeId: event.employeeId,
        services: event.services));
    failureOrSuccess.fold((failure) async {
      emit(SendRequestError(failure: failure));
    }, (data) async {
      emit(SendRequestLoaded());
    });
  }
}
