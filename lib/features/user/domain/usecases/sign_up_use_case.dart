import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final UserRepository userRepository;
  SignUpUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams signUpParams) async {
    return await userRepository.signUp(
        email: signUpParams.email,
        name: signUpParams.name,
        password: signUpParams.password,
        birthdate: signUpParams.birthdate);
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;
  final String birthdate;

  SignUpParams(
      {required this.email,
      required this.name,
      required this.password,
      required this.birthdate});
}
