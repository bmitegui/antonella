import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUseCase implements UseCase<List<OrderEntity>, GetOrdersParams> {
  final ServiceRepository serviceRepository;
  GetOrdersUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(
      GetOrdersParams getOrdersParams) async {
    return await serviceRepository.getOrders(id: getOrdersParams.id);
  }
}

class GetOrdersParams {
  final String id;
  GetOrdersParams({required this.id});
}
