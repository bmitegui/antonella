import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetPromotionsRelatedUseCase
    implements UseCase<List<PromotionEntity>, GetPromotionsRelatedParams> {
  final ServiceRepository serviceRepository;
  GetPromotionsRelatedUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<PromotionEntity>>> call(
      GetPromotionsRelatedParams getPromotionsRelated) async {
    return await serviceRepository.getPromotionsRelated(
        servicesId: getPromotionsRelated.servicesId,
        productsId: getPromotionsRelated.productsId);
  }
}

class GetPromotionsRelatedParams {
  final List<String> servicesId;
  final List<String> productsId;

  GetPromotionsRelatedParams(
      {required this.servicesId, required this.productsId});
}
