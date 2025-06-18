import 'package:equatable/equatable.dart';

enum AppointmentStatus { noConfirmado, confirmado }

class AppointmentEntity extends Equatable {
  final String id;
  final DateTime createdDate;

  const AppointmentEntity({required this.id, required this.createdDate});

  @override
  List<Object?> get props => [id];
}
