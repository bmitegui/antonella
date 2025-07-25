import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/utils/repository_impl_util.dart';
import 'package:antonella/features/user/data/datasources/datasources.dart';
import 'package:antonella/features/user/data/models/models.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
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
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final remoteUser = await userRemoteDataSource.signIn(
              account: account, password: password);
          if (rememberMe) {
            await userLocalDataSource.uploadLocalUser(userModel: remoteUser);
          }
          return remoteUser;
        });
  }

  @override
  Future<Either<Failure, UserModel>> signUp(
      {required String account,
      required String dni,
      required String name,
      required String password,
      required String birthdate,
      required String phoneNumber,
      required String? genero}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final remoteUser = await userRemoteDataSource.signUp(
              account: account,
              dni: dni,
              name: name,
              password: password,
              birthdate: birthdate,
              phoneNumber: phoneNumber,
              genero: genero);
          await userLocalDataSource.uploadLocalUser(userModel: remoteUser);
          return remoteUser;
        });
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    await handleLocalCall(operation: () async {
      await userLocalDataSource.signOut();
      return;
    });

    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await userRemoteDataSource.signOut();
        });
  }

  @override
  Future<Either<Failure, List<String>>> passwordCode(
      {required String email}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final lista = await userRemoteDataSource.passwordCode(email: email);
          return lista;
        });
  }

  @override
  Future<Either<Failure, void>> passwordReset(
      {required String id, required String password}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await userRemoteDataSource.passwordReset(id: id, password: password);
        });
  }

  @override
  Future<Either<Failure, EmployeeInfoModel>> getEmployeeInfo(
      {required String employeeId,
      required String startDate,
      required String endDate}) async {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          final lista = await userRemoteDataSource.getEmployeeInfo(
              employeeId: employeeId, startDate: startDate, endDate: endDate);
          return lista;
        });
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages() {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          return await userRemoteDataSource.getMessages();
        });
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      {required String userId,
      required String content,
      required MessageType type}) {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await userRemoteDataSource.sendMessage(
              userId: userId, content: content, type: type);
        });
  }

  @override
  Future<Either<Failure, void>> addProfile(
      {required String id, required String urlPhoto}) {
    return handleNetworkCall(
        networkInfo: networkInfo,
        operation: () async {
          await userRemoteDataSource.addProfile(id: id, urlPhoto: urlPhoto);
        });
  }
}
