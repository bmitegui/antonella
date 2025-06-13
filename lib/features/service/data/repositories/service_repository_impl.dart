import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final NetworkInfo networkInfo;
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepositoryImpl(
      {required this.networkInfo, required this.serviceRemoteDataSource});

  @override
  Future<Either<Failure, ListServicesModel>> getServices() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteServices = await serviceRemoteDataSource.getServices();
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

  @override
  Future<Either<Failure, List<CommentModel>>> getServiceComments(
      {required String serviceId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteServiceComments = await serviceRemoteDataSource
            .getServiceComments(serviceId: serviceId);
        return Right(remoteServiceComments);
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
  Future<Either<Failure, void>> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required ServiceEntity service}) async {
    if (await networkInfo.isConnected) {
      try {
        await serviceRemoteDataSource.sendRequest(
            clientId: clientId,
            day: day,
            start: start,
            employeeId: employeeId,
            service: service);
        return Right(null);
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
