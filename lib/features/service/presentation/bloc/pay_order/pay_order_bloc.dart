import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/pay_order_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'pay_order_event.dart';
part 'pay_order_state.dart';

class PayOrderBloc extends Bloc<PayOrderEvent, PayOrderState> {
  final PayOrderUseCase payOrderUseCase;

  PayOrderBloc({required this.payOrderUseCase}) : super(PayOrderInitial()) {
    on<PagarOrdenEvent>(_onPagarOrdenEventRequest);
  }

  Future<void> _onPagarOrdenEventRequest(
      PagarOrdenEvent event, Emitter<PayOrderState> emit) async {
    emit(PayOrderLoading());
    final failureOrSuccess = await payOrderUseCase(
        PayOrderParams(orderId: event.orderId, paymentType: event.paymentType));
    failureOrSuccess.fold((failure) async {
      emit(PayOrderError(failure: failure));
    }, (data) async {
      emit(PayOrderLoaded());
    });
  }
}
