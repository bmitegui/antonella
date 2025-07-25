import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfileUserUseCase implements UseCase<void, AddProfileParams> {
  final UserRepository userRepository;
  GetProfileUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(AddProfileParams addProfileParams) async {
    return await userRepository.addProfile(
      id: addProfileParams.id,
      urlPhoto: addProfileParams.url);
  }
}

class AddProfileParams {
  final String id;
  final String url;

  AddProfileParams({required this.id, required this.url});
}
