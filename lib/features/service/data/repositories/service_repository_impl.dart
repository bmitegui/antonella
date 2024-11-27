import 'package:antonella/core/constant/error_messages.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final NetworkInfo networkInfo;
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepositoryImpl(
      {required this.networkInfo, required this.serviceRemoteDataSource});

  @override
  Future<Either<Failure, ListServicesModel>> getServices(
      {required String? filter}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteServices =
            await serviceRemoteDataSource.getServices(filter: filter);
        return Right(remoteServices);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure(message: networkConnectionError));
    }
  }
}
