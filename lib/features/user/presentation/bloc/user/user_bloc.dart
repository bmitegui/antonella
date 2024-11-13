import 'package:antonella/core/constant/error_messages.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final CheckAuthenticationUseCase checkAuthenticationUseCase;

  UserBloc(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.signOutUseCase,
      required this.checkAuthenticationUseCase})
      : super(UserInitial()) {
    on<SignInEvent>(_onSignInEventRequest);
    on<SignUpEvent>(_onSignUpEventRequest);
    on<CheckAuthenticationEvent>(_onCheckAuthenticationEventRequest);
    on<SignOutEvent>(_onSignOutEventRequest);
  }

  Future<void> _onSignOutEventRequest(
      SignOutEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrSuccess = await signOutUseCase(NoParams());
    failureOrSuccess.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
      emit(UserAuthenticated(user: event.userEntity));
    }, (user) async {
      emit(UserUnauthenticated());
    });
  }

  Future<void> _onSignInEventRequest(
      SignInEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await signInUseCase(
        SignInParams(email: event.email, password: event.password, rememberMe: event.rememberMe));
    failureOrUser.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
    }, (user) async {
      emit(UserAuthenticated(user: user));
    });
  }

  Future<void> _onCheckAuthenticationEventRequest(
      CheckAuthenticationEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrValue = await checkAuthenticationUseCase(NoParams());
    failureOrValue.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
      emit(UserUnauthenticated());
    }, (user) async {
      emit(UserAuthenticated(user: user));
    });
  }

  Future<void> _onSignUpEventRequest(
      SignUpEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await signUpUseCase(SignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
        birthdate: event.birthdate));
    failureOrUser.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
    }, (user) async {
      emit(UserAuthenticated(user: user));
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
