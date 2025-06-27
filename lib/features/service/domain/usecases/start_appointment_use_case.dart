import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class StartAppointmentUseCase implements UseCase<void, StartAppointmentParams> {
  final ServiceRepository serviceRepository;
  StartAppointmentUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, void>> call(
      StartAppointmentParams startAppointmentParams) async {
    return await serviceRepository.startAppointment(
        orderId: startAppointmentParams.orderId,
        appointmentId: startAppointmentParams.appointmentId);
  }
}

class StartAppointmentParams {
  final String orderId;
  final String appointmentId;
  StartAppointmentParams({required this.orderId, required this.appointmentId});
}
