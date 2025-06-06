import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class PasswordCodeUseCase implements UseCase<String, PasswordCodeParams> {
  final UserRepository userRepository;
  PasswordCodeUseCase({required this.userRepository});

  @override
  Future<Either<Failure, String>> call(
      PasswordCodeParams passwordCodeParams) async {
    return await userRepository.passwordCode(email: passwordCodeParams.email);
  }
}

class PasswordCodeParams {
  final String email;
  PasswordCodeParams({required this.email});
}
