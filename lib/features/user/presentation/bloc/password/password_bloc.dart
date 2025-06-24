import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordCodeUseCase passwordCodeUseCase;
  final PasswordResetUseCase passwordResetUseCase;

  PasswordBloc(
      {required this.passwordCodeUseCase, required this.passwordResetUseCase})
      : super(PasswordInitial()) {
    on<PasswordCodeEvent>(_onPasswordCodeEventRequest);
    on<PasswordResetEvent>(_onPasswordResetEventRequest);
  }

  Future<void> _onPasswordResetEventRequest(
      PasswordResetEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoading());
    final failureOrSuccess = await passwordResetUseCase(
        PasswordResetParams(id: event.id, password: event.password));
    failureOrSuccess.fold((failure) {
      emit(PasswordError(failure: failure));
      emit(PasswordLoaded(code: '', userId: event.id));
    }, (vacio) async {
      emit(PasswordReseted());
    });
  }

  Future<void> _onPasswordCodeEventRequest(
      PasswordCodeEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoading());
    final failureOrSuccess =
        await passwordCodeUseCase(PasswordCodeParams(email: event.email));
    failureOrSuccess.fold((failure) {
      emit(PasswordError(failure: failure));
    }, (lista) async {
      emit(PasswordLoaded(code: lista[0], userId: lista[1]));
    });
  }
}
