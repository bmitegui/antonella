import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.messageId,
      required super.senderId,
      required super.userId,
      required super.content,
      required super.dateTime,
      required super.messageType});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        messageId: json['id'],
        senderId: json['sender_id'],
        userId: json['sender_id'],
        content: json['content'],
        dateTime: parseStringToDate(json['timestamp']),
        messageType: stringToMessageType(json['message_type']));
  }
}
