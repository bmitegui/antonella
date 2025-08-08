import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class AddCardUseCase implements UseCase<void, AddCardParams> {
  final UserRepository userRepository;
  AddCardUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(AddCardParams addCardParams) async {
    return await userRepository.addCard(
        userId: addCardParams.userId,
        number: addCardParams.number,
        expiryMonth: addCardParams.expiryMonth,
        expiryYear: addCardParams.expiryYear,
        cvc: addCardParams.cvc);
  }
}

class AddCardParams {
  final String userId;
  final String number;
  final int expiryMonth;
  final int expiryYear;
  final String cvc;

  AddCardParams(
      {required this.userId,
      required this.number,
      required this.expiryMonth,
      required this.expiryYear,
      required this.cvc});
}
