import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase implements UseCase<UserEntity, SignInParams> {
  final UserRepository userRepository;
  SignInUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams signInParams) async {
    return await userRepository.signIn(
        email: signInParams.email,
        password: signInParams.password,
        rememberMe: signInParams.rememberMe);
  }
}

class SignInParams {
  final String email;
  final String password;
  final bool rememberMe;
  SignInParams(
      {required this.email, required this.password, required this.rememberMe});
}