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
  Future<Either<Failure, ListServicesModel>> getServices(
      {required ServiceCategory? filter}) async {
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

  @override
  Future<Either<Failure, List<ServiceFormModel>>> getListServiceForm(
      {required ServiceCategory category}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListServiceForms = await serviceRemoteDataSource
            .getListServiceForm(category: category);
        return Right(remoteListServiceForms);
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
}
