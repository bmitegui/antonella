import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:dartz/dartz.dart';

Future<Either<Failure, T>> handleNetworkCall<T>(
    {required Future<T> Function() operation,
    required NetworkInfo networkInfo}) async {
  if (await networkInfo.isConnected) {
    try {
      final result = await operation();
      return Right(result);
    } on NetworkConnectionException {
      return Left(NetworkConnectionFailure());
    } on IncorrectPasswordException {
      return Left(IncorrectPasswordFailure());
    } on IncompleteFieldsException {
      return Left(IncompleteFieldsFailure());
    } on InvalidUserEmailException {
      return Left(InvalidUserEmailFailure());
    } on InvalidUserBirthdateException {
      return Left(InvalidUserBirthdateFailure());
    } on UserAlreadyExistsException {
      return Left(UserAlreadyExistsFailure());
    } on InvalidUserNameException {
      return Left(InvalidUserNameFailure());
    } on InvalidDniException {
      return Left(InvalidDniFailure());
    } on InvalidPhoneNumberException {
      return Left(InvalidPhoneNumberFailure());
    } on ModelNotFoundException {
      return Left(ModelNotFoundFailure());
    } on InvalidUserPasswordException {
      return Left(InvalidUserPasswordFailure());
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  } else {
    return Left(NetworkConnectionFailure());
  }
}

Future<Either<Failure, T>> handleLocalCall<T>(
    {required Future<T> Function() operation}) async {
  try {
    final result = await operation();
    return Right(result);
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
