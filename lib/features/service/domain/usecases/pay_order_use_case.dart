import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class PayOrderUseCase implements UseCase<void, PayOrderParams> {
  final ServiceRepository serviceRepository;
  PayOrderUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, void>> call(PayOrderParams payOrderParams) async {
    return await serviceRepository.payOrder(
        paymentType: payOrderParams.paymentType);
  }
}

class PayOrderParams {
  final PaymentType paymentType;
  PayOrderParams({required this.paymentType});
}
