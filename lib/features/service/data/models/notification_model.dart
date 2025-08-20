import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required super.id,
      required super.title,
      required super.body,
      required super.createdAt,
      required super.notificationType});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: '${json['id']}',
        title: capitalize(json['title']),
        body: capitalize(json['body']),
        createdAt: parseStringToDate(json['created_at']).toLocal(),
        notificationType: stringToNotificationType(json['notification_type']));
  }
}
