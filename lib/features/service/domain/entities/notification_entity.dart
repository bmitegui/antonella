import 'package:equatable/equatable.dart';

enum NotificationType { instantanea, otro }

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final NotificationType notificationType;

  const NotificationEntity(
      {required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.notificationType});

  @override
  List<Object?> get props => [id];
}
