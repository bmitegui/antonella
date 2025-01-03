import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'services_selected_event.dart';
part 'services_selected_state.dart';

class ServicesSelectedBloc
    extends Bloc<ServicesSelectedEvent, ServicesSelectedState> {
  ServicesSelectedBloc()
      : super(ServicesSelectedLoaded(
            listServicesSelected: [], dateSelected: null, timeSelected: null)) {
    on<AddServiceSelectedEvent>(_onAddServiceSelectedEventRequest);
    on<DeleteServiceSelectedEvent>(_onDeleteServiceSelectedEventRequest);
    on<SelectTimeEvent>(_onSelectTimeEventRequest);
    on<SelectDateTimeEvent>(_onSelectDateTimeEventRequest);
    on<ClearServicesSelectedEvent>(_onClearServicesSelectedEventRequest);
  }

  Future<void> _onClearServicesSelectedEventRequest(
      ClearServicesSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    emit(ServicesSelectedLoaded(
        listServicesSelected: [], dateSelected: null, timeSelected: null));
  }

  Future<void> _onSelectDateTimeEventRequest(
      SelectDateTimeEvent event, Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    emit(ServicesSelectedLoaded(
        listServicesSelected: event.listServicesSelected,
        dateSelected: event.dateSelected,
        timeSelected: event.timeSelected));
  }

  Future<void> _onAddServiceSelectedEventRequest(AddServiceSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    final updatedList = List<ServiceEntity>.from(event.listServicesSelected);
    final index = updatedList
        .indexWhere((service) => service.id == event.serviceEntitySelected.id);
    if (index != -1) {
      updatedList[index] =
          event.serviceEntitySelected.copyWith(isSelected: true);
    } else {
      updatedList.add(event.serviceEntitySelected.copyWith(isSelected: true));
    }
    emit(ServicesSelectedLoaded(
      listServicesSelected: updatedList,
      dateSelected: event.dateSelected,
      timeSelected: event.timeSelected,
    ));
  }

  Future<void> _onDeleteServiceSelectedEventRequest(
      DeleteServiceSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    final updatedList = List<ServiceEntity>.from(event.listServicesSelected)
      ..remove(event.serviceEntitySelected);
    emit(ServicesSelectedLoaded(
        listServicesSelected: updatedList,
        dateSelected: event.dateSelected,
        timeSelected: event.timeSelected));
  }

  Future<void> _onSelectTimeEventRequest(
      SelectTimeEvent event, Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    emit(ServicesSelectedLoaded(
        listServicesSelected: event.listServicesSelected,
        dateSelected: event.dateSelected,
        timeSelected: event.timeSelected));
  }
}
