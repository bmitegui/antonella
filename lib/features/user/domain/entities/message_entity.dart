import 'package:equatable/equatable.dart';

enum MessageType { text, image }

class MessageEntity extends Equatable {
  final String messageId;
  final String senderId;
  final String userId;
  final String content;
  final DateTime dateTime;
  final MessageType messageType;

  const MessageEntity(
      {required this.messageId,
      required this.senderId,
      required this.userId,
      required this.content,
      required this.dateTime,
      required this.messageType});

  @override
  List<Object?> get props => [messageId, content];
}
