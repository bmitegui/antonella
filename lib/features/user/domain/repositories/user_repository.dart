import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });
  Future<Either<Failure, UserModel>> signUp({
    required String email,
    required String name,
    required String password,
    required String birthdate,
  });
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel>> checkAuthentication();
}
