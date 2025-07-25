import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetAdminUseCase implements UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;
  GetAdminUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams noParams) async {
    return await userRepository.getAdmin();
  }
}
