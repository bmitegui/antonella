import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class PasswordResetUseCase implements UseCase<void, PasswordResetParams> {
  final UserRepository userRepository;
  PasswordResetUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(
      PasswordResetParams passwordResetParams) async {
    return await userRepository.passwordReset(
        id: passwordResetParams.id, password: passwordResetParams.password);
  }
}

class PasswordResetParams {
  final String id;
  final String password;
  PasswordResetParams({required this.id, required this.password});
}
