import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/get_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationsBloc({required this.getNotificationsUseCase})
      : super(NotificationsInitial()) {
    on<GetNotificationsEvent>(_onGetNotificationsEventRequest);
  }
  Future<void> _onGetNotificationsEventRequest(
      GetNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    final failureOrSuccess = await getNotificationsUseCase(NoParams());
    failureOrSuccess.fold((failure) async {
      emit(NotificationsError(failure: failure));
    }, (notifications) async {
      emit(NotificationsLoaded(notifications: notifications));
    });
  }
}
