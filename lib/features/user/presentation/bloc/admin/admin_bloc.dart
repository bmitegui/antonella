import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final GetAdminUseCase getAdminUseCase;

  AdminBloc({required this.getAdminUseCase}) : super(AdminInitial()) {
    on<GetAdminEvent>(_onGetAdminEventRequest);
  }

  Future<void> _onGetAdminEventRequest(
      GetAdminEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    final failureOrSuccess = await getAdminUseCase(NoParams());
    failureOrSuccess.fold((failure) {
      emit(AdminError(failure: failure));
    }, (employeeEntity) async {
      emit(AdminLoaded(userEntity: employeeEntity));
    });
  }
}
