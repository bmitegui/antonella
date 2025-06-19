import 'package:antonella/core/constant/constant.dart';
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
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  } else {
    return Left(ServerFailure(message: networkConnectionError));
  }
}

Future<Either<Failure, T>> handleLocalCall<T>({
  required
    Future<T> Function() operation}) async {
  try {
    final result = await operation();
    return Right(result);
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
