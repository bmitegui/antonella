import 'package:antonella/core/constant/constant.dart';
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
      {required String account,
      required String password,
      required bool rememberMe}) async {
    if (await networkInfo.isConnected) {
    
      try {
        final remoteUser = await userRemoteDataSource.signIn(
            account: account, password: password);
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
      {required String account,
      required String name,
      required String password,
      required String birthdate, required String phoneNumber, required String genero}) async {
     if (await networkInfo.isConnected) {
      try {
        final remoteUser = await userRemoteDataSource.signUp(
            account: account,
            name: name,
            password: password,
            birthdate: birthdate,
            phoneNumber: phoneNumber,
            genero: genero);
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
}
