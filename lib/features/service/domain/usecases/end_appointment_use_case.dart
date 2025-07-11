import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/service/domain/repositories/service_repository.dart';
import 'package:dartz/dartz.dart';

class EndAppointmentUseCase implements UseCase<void, EndAppointmentParams> {
  final ServiceRepository serviceRepository;
  EndAppointmentUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, void>> call(
      EndAppointmentParams endAppointmentParams) async {
    return await serviceRepository.endAppointment(
        orderId: endAppointmentParams.orderId,
        appointmentId: endAppointmentParams.appointmentId);
  }
}

class EndAppointmentParams {
  final String orderId;
  final String appointmentId;
  EndAppointmentParams({required this.orderId, required this.appointmentId});
}
