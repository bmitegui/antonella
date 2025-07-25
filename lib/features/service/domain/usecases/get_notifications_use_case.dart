import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUseCase implements UseCase<List<NotificationEntity>, NoParams> {
  final ServiceRepository serviceRepository;
  GetNotificationsUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      NoParams noParams) async {
    return await serviceRepository.getNotifications();
  }
}