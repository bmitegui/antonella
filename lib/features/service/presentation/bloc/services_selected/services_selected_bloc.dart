import 'package:antonella/core/error/failures.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'services_selected_event.dart';
part 'services_selected_state.dart';

class ServicesSelectedBloc
    extends Bloc<ServicesSelectedEvent, ServicesSelectedState> {
  ServicesSelectedBloc()
      : super(ServicesSelectedLoaded(
            services: [], dateSelected: null, timeSelected: null)) {
    on<AddServiceEvent>(_onAddServiceEventRequest);
    on<DeleteServiceEvent>(_onDeleteServiceEventRequest);
    on<SelectTimeEvent>(_onSelectTimeEventRequest);
    on<SelectDateTimeEvent>(_onSelectDateTimeEventRequest);
    on<ClearServicesSelectedEvent>(_onClearServicesSelectedEventRequest);
  }
  Future<void> _onClearServicesSelectedEventRequest(
      ClearServicesSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    emit(ServicesSelectedLoaded(
        services: [], dateSelected: null, timeSelected: null));
  }

  Future<void> _onSelectDateTimeEventRequest(
      SelectDateTimeEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(dateSelected: event.dateSelected));
    }
  }

  Future<void> _onAddServiceEventRequest(
    AddServiceEvent event,
    Emitter<ServicesSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      final services = List<ServiceEntity>.from(currentState.services);
      final index = services.indexWhere((s) => s.id == event.service.id);

      if (index != -1) {
        services[index] = event.service;
      } else {
        services.add(event.service);
      }

      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(services: services));
    }
  }

  Future<void> _onDeleteServiceEventRequest(
      DeleteServiceEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      final services = currentState.services;
      services.removeWhere((service) => service.id == event.service.id);
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(services: services));
    }
  }

  Future<void> _onSelectTimeEventRequest(
      SelectTimeEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(timeSelected: event.timeSelected));
    }
  }
}
