import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class CheckAuthenticationUseCase implements UseCase<UserModel, NoParams> {
  final UserRepository userRepository;
  CheckAuthenticationUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams noParams) async {
    return await userRepository.checkAuthentication();
  }
}
