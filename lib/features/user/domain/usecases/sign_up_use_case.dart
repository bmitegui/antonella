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
        account: signUpParams.account,
        dni: signUpParams.dni,
        name: signUpParams.name,
        password: signUpParams.password,
        birthdate: signUpParams.birthdate,
        phoneNumber: signUpParams.phoneNumber,
        genero: signUpParams.genero);
  }
}

class SignUpParams {
  final String account;
  final String dni;
  final String name;
  final String password;
  final String birthdate;
  final String? genero;
  final String phoneNumber;

  SignUpParams(
      {required this.account,
      required this.dni,
      required this.name,
      required this.password,
      required this.birthdate,
      required this.genero,
      required this.phoneNumber});
}
