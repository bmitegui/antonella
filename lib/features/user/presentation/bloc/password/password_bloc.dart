import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordCodeUseCase passwordCodeUseCase;

  PasswordBloc({required this.passwordCodeUseCase}) : super(PasswordInitial()) {
    on<PasswordCodeEvent>(_onPasswordCodeEventRequest);
  }

  Future<void> _onPasswordCodeEventRequest(
      PasswordCodeEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoading());
    final failureOrSuccess =
        await passwordCodeUseCase(PasswordCodeParams(email: event.email));
    failureOrSuccess.fold((failure) {
      emit(PasswordError(message: _mapFailureToMessage(failure)));
    }, (code) async {
      emit(PasswordLoaded(code: code));
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
