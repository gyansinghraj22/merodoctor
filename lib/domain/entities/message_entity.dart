class MessageEntity {
  final int messageId;
  final int chatRoomId;
  final int senderId;
  final String content;
  final DateTime timestamp;
  final String messageType; // 'Text', 'Image', 'File', 'Notification'

  MessageEntity({
    required this.messageId,
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.messageType,
  });
}
