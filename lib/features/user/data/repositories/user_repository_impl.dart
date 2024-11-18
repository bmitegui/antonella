import 'package:antonella/core/constant/error_messages.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/features/user/data/datasources/datasources.dart';
import 'package:antonella/features/user/data/models/user_model.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl(
      {required this.networkInfo,
      required this.userRemoteDataSource,
      required this.userLocalDataSource});

  @override
  Future<Either<Failure, UserModel>> signIn(
      {required String email,
      required String password,
      required bool rememberMe}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await userRemoteDataSource.signIn(email: email, password: password);
        if (rememberMe) {
          await userLocalDataSource.uploadLocalUser(userModel: remoteUser);
        }
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure(message: networkConnectionError));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(
      {required String email,
      required String name,
      required String password,
      required String birthdate}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await userRemoteDataSource.signUp(
            email: email, name: name, password: password, birthdate: birthdate);
        await userLocalDataSource.uploadLocalUser(userModel: remoteUser);
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure(message: networkConnectionError));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await userLocalDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> checkAuthentication() async {
    try {
      final localUser = await userLocalDataSource.checkUserAuthentication();
      if (localUser != null) {
        return Right(localUser);
      } else {
        return Left(ServerFailure(message: userNotAuthenticatedError));
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
