import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServicesUseCase getServicesUseCase;

  ServiceBloc({required this.getServicesUseCase}) : super(ServiceInitial()) {
    on<GetServicesEvent>(_onGetServicesEventRequest);
  }

  Future<void> _onGetServicesEventRequest(
      GetServicesEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());
    final failureOrSuccess =
        await getServicesUseCase(GetServicesParams(filter: event.filter));
    failureOrSuccess.fold((failure) async {
      emit(ServicesError(message: _mapFailureToMessage(failure)));
    }, (listServices) async {
      emit(ServicesLoaded(
          listServices: listServices, serviceCategory: event.filter));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return unexpectedError;
    }
  }
}
