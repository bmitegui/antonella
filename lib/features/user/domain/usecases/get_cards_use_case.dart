import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/card_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetCardsUseCase implements UseCase<List<CardEntity>, GetCardsParams> {
  final UserRepository userRepository;
  GetCardsUseCase({required this.userRepository});

  @override
  Future<Either<Failure, List<CardEntity>>> call(
      GetCardsParams getCardsParams) async {
    return await userRepository.getCards(userId: getCardsParams.userId);
  }
}

class GetCardsParams {
  final String userId;

  GetCardsParams({required this.userId});
}
