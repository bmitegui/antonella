import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> signIn({
    required String account,
    required String password,
    required bool rememberMe,
  });
  Future<Either<Failure, UserModel>> signUp(
      {required String account,
      required String dni,
      required String name,
      required String password,
      required String birthdate,
      required String? genero,
      required String phoneNumber});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, List<String>>> passwordCode({required String email});
  Future<Either<Failure, void>> passwordReset(
      {required String id, required String password});
  Future<Either<Failure, EmployeeInfoModel>> getEmployeeInfo(
      {required String employeeId,
      required String startDate,
      required String endDate});
  Future<Either<Failure, MessageModel>> getMessages();
}
