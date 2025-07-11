import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetPromotionsUseCase implements UseCase<List<PromotionEntity>, NoParams> {
  final ServiceRepository serviceRepository;
  GetPromotionsUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<PromotionEntity>>> call(
      NoParams noParams) async {
    return await serviceRepository.getPromotions();
  }
}