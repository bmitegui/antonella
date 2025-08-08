import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class DebitCardUseCase implements UseCase<void, DebitCardParams> {
  final UserRepository userRepository;
  DebitCardUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(DebitCardParams debitCardParams) async {
    return await userRepository.debitCard(
        userId: debitCardParams.userId,
        orderId: debitCardParams.orderId,
        taxableAmount: debitCardParams.taxableAmount);
  }
}

class DebitCardParams {
  final String userId;
  final String orderId;
  final double taxableAmount;

  DebitCardParams(
      {required this.userId,
      required this.orderId,
      required this.taxableAmount});
}
