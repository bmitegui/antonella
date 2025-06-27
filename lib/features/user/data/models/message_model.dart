
import 'package:antonella/features/user/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.messageId,
      required super.userId,
      required super.content,
      required super.dateTime,
      required super.messageType});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        messageId: json['id'],
        userId: json['sender_id'],
        content: json['content'],
        dateTime: json['timestamp'],
        messageType: json['message_type']);
  }
}
