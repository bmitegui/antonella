import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfileUserUseCase implements UseCase<String, NoParams> {
  final UserRepository userRepository;
  GetProfileUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await userRepository.addProfile();
  }
}
