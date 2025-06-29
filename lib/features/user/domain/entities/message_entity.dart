enum MessageType { text, image }

class MessageEntity {
  final String messageId;
  final String senderId;
  final String userId;
  final String content;
  final DateTime dateTime;
  final MessageType messageType;

  MessageEntity({
      required this.messageId, 
      required this.senderId,
      required this.userId, 
      required this.content, 
      required this.dateTime, 
      required this.messageType});
}
