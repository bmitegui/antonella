import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfileUserUseCase
    implements UseCase<UserEntity, UpdateProfileParams> {
  final UserRepository userRepository;
  GetProfileUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(
      UpdateProfileParams updateProfileParams) async {
    return await userRepository.updateProfile(
        userId: updateProfileParams.userId,
        base64Photo: updateProfileParams.base64Photo,
        name: updateProfileParams.name,
        phoneNumber: updateProfileParams.phoneNumber,
        gmail: updateProfileParams.gmail);
  }
}

class UpdateProfileParams {
  final String userId;
  final String? base64Photo;
  final String? name;
  final String? phoneNumber;
  final String? gmail;

  UpdateProfileParams(
      {required this.userId,
      required this.base64Photo,
      required this.name,
      required this.phoneNumber,
      required this.gmail});
}
