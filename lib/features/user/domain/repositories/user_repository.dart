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
      required String name,
      required String password,
      required String birthdate,
      required String genero,
      required String phoneNumber});
  Future<Either<Failure, void>> signOut();
}
