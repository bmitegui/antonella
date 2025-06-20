import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase getOrderssUseCase;

  OrdersBloc({required this.getOrderssUseCase}) : super(OrdersInitial()) {
    on<GetOrdersEvent>(_onGetOrdersEventRequest);
  }

  Future<void> _onGetOrdersEventRequest(
      GetOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    final failureOrSuccess =
        await getOrderssUseCase(GetOrdersParams(id: event.id));
    failureOrSuccess.fold((failure) async {
      emit(OrdersError(message: _mapFailureToMessage(failure)));
    }, (orders) async {
      emit(OrdersLoaded(orders: orders));
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
