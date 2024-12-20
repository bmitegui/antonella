import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final UserRepository userRepository;
  SignOutUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await userRepository.signOut();
  }
}
