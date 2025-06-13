import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/services/services.dart';
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
  final KeyValueStorageServiceImpl keyValueStorageService;

  UserBloc(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.signOutUseCase,
      required this.keyValueStorageService})
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
    failureOrSuccess.fold((failure) async {
      if (event.userEntity != null) {
        emit(UserError(message: _mapFailureToMessage(failure)));
        emit(UserAuthenticated(user: event.userEntity!));
      } else {
        emit(UserUnauthenticated());
        await keyValueStorageService.removeKey('account');
        await keyValueStorageService.removeKey('password');
      }
    }, (user) async {
      emit(UserUnauthenticated());
      await keyValueStorageService.removeKey('account');
      await keyValueStorageService.removeKey('password');
    });
  }

  Future<void> _onSignInEventRequest(
      SignInEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await signInUseCase(SignInParams(
        account: event.account,
        password: event.password,
        rememberMe: event.rememberMe));
    failureOrUser.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
      if (event.checkAuthentication) {
        emit(UserUnauthenticated());
      }
    }, (user) async {
      emit(UserAuthenticated(user: user));
      if (event.rememberMe) {
        await keyValueStorageService.setKeyValue('account', user.phoneNumber);
        await keyValueStorageService.setKeyValue('password', event.password);
      }
    });
  }

  Future<void> _onCheckAuthenticationEventRequest(
      CheckAuthenticationEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final account = await keyValueStorageService.getValue<String>('account');
    final password = await keyValueStorageService.getValue<String>('password');

    if (account == null ||
        password == null ||
        account.trim().isEmpty ||
        password.trim().isEmpty) {
      add(SignOutEvent(userEntity: null));
    } else {
      add(SignInEvent(
          account: account,
          password: password,
          rememberMe: true,
          checkAuthentication: true));
    }
  }

  Future<void> _onSignUpEventRequest(
      SignUpEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await signUpUseCase(SignUpParams(
        dni: event.dni,
        phoneNumber: event.phoneNumber,
        genero: event.genero,
        account: event.account,
        name: event.name,
        password: event.password,
        birthdate: event.birthdate));
    failureOrUser.fold((failure) {
      emit(UserError(message: _mapFailureToMessage(failure)));
      emit(UserUnauthenticated());
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
