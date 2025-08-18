import 'package:antonella/core/error/failures.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'services_selected_event.dart';
part 'services_selected_state.dart';

class ServicesSelectedBloc
    extends Bloc<ServicesSelectedEvent, ServicesSelectedState> {
  ServicesSelectedBloc()
      : super(ServicesSelectedLoaded(
          services: [],
          products: [],
          dateSelected: null,
          timeSelected: null,
          employeeIds: null,
        )) {
    // Eventos de servicios
    on<AddServiceEvent>(_onAddServiceEventRequest);
    on<DeleteServiceEvent>(_onDeleteServiceEventRequest);
    on<SelectTimeEvent>(_onSelectTimeEventRequest);
    on<SelectDateTimeEvent>(_onSelectDateTimeEventRequest);
    on<ClearServicesSelectedEvent>(_onClearServicesSelectedEventRequest);
    on<SelectEmployeeEvent>(_onSelectEmployeeEventRequest);

    // Eventos de productos
    on<AddProductEvent>(_onAddProductEventRequest);
    on<DeleteProductEvent>(_onDeleteProductEventRequest);
    on<UpdateProductQuantityEvent>(_onUpdateProductQuantityEventRequest);
    on<ClearProductSelectedEvent>(_onClearProductsSelectedEventRequest);
  }

  // ----------------- Lógica de Servicios -----------------
  Future<void> _onClearServicesSelectedEventRequest(
      ClearServicesSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    emit(ServicesSelectedLoading());
    emit(ServicesSelectedLoaded(
        services: [],
        products: [],
        dateSelected: null,
        timeSelected: null,
        employeeIds: null));
  }

  Future<void> _onSelectDateTimeEventRequest(
      SelectDateTimeEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(dateSelected: event.dateSelected));
    }
  }

  Future<void> _onSelectEmployeeEventRequest(
      SelectEmployeeEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      emit(ServicesSelectedLoading());
      final newEmployeeIds =
          Map<String, String>.from(currentState.employeeIds ?? {});
      newEmployeeIds[event.serviceId] = event.employeeId;
      emit(currentState.copyWith(employeeIds: newEmployeeIds));
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
      final services = List<ServiceEntity>.from(currentState.services);
      services.removeWhere((service) => service.id == event.service.id);

      // Eliminar del mapa de empleados si existía
      final newEmployeeIds =
          Map<String, String>.from(currentState.employeeIds ?? {});
      newEmployeeIds.remove(event.service.id);

      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(
        services: services,
        employeeIds: newEmployeeIds, // actualizar mapa
      ));
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

  // ----------------- Lógica de Productos -----------------
  Future<void> _onClearProductsSelectedEventRequest(
      ClearProductSelectedEvent event,
      Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(products: []));
    }
  }

  Future<void> _onAddProductEventRequest(
    AddProductEvent event,
    Emitter<ServicesSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      final List<ProductEntity> original = currentState.products;
      final List<ProductEntity> updatedProducts = [];

      bool inserted = false;
      int insertIndex = -1;

      for (int i = 0; i < original.length; i++) {
        final product = original[i];
        if (product.id == event.product.id) {
          if (!inserted) {
            insertIndex = updatedProducts.length;
            inserted = true;
          }
          continue;
        }
        updatedProducts.add(product);
      }

      final newItems = List.generate(event.cant, (_) => event.product);

      if (inserted) {
        updatedProducts.insertAll(insertIndex, newItems);
      } else {
        updatedProducts.addAll(newItems);
      }

      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  Future<void> _onUpdateProductQuantityEventRequest(
    UpdateProductQuantityEvent event,
    Emitter<ServicesSelectedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      final List<ProductEntity> updatedProducts = [];

      bool inserted = false;

      for (int i = 0; i < currentState.products.length; i++) {
        final product = currentState.products[i];

        if (product.id == event.product.id) {
          if (!inserted) {
            updatedProducts.addAll(
              List.generate(event.newQuantity, (_) => event.product),
            );
            inserted = true;
          }
          continue; // no duplicar
        }

        updatedProducts.add(product);
      }

      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  Future<void> _onDeleteProductEventRequest(
      DeleteProductEvent event, Emitter<ServicesSelectedState> emit) async {
    final currentState = state;
    if (currentState is ServicesSelectedLoaded) {
      final products = List<ProductEntity>.from(currentState.products);
      products.removeWhere((product) => product.id == event.product.id);
      emit(ServicesSelectedLoading());
      emit(currentState.copyWith(products: products));
    }
  }
}
