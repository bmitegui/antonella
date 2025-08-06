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
        await getServicesUseCase(GetServicesParams(name: event.name));
    failureOrSuccess.fold((failure) async {
      emit(ServicesError(failure: failure));
    }, (listServices) async {
      if (event.serviceType != null && event.serviceType != ServiceType.all) {
        final servicesFilter = listServices.services
            .where((service) => service.type == event.serviceType)
            .toList();
        emit(ServicesLoaded(
            listServices: listServices.copyWith(services: servicesFilter),
            serviceType: event.serviceType!,
            isFiltered: event.name != null));
      } else {
        emit(ServicesLoaded(
            listServices: listServices, isFiltered: event.name != null));
      }
    });
  }
}
