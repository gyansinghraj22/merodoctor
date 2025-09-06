import 'package:merodoctor/domain/entities/message_entity.dart'; // Ensure this path is correct

/// Represents the data model for a Message, extending MessageEntity.
/// This class handles JSON serialization and deserialization.
class MessageModel extends MessageEntity {
  MessageModel({
    required super.messageId,
    required super.chatRoomId,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.messageType,
  });

  /// Factory constructor to create a MessageModel instance from a JSON map.
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    messageId: json['messageId'] as int,
    chatRoomId: json['chatRoomId'] as int,
    senderId: json['senderId'] as int,
    content: json['content'] as String,
    // Parse ISO 8601 string back to DateTime
    timestamp: DateTime.parse(json['timestamp'] as String),
    messageType: json['messageType'] as String,
  );

  /// Converts this MessageModel instance to a JSON-compatible map.

  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'chatRoomId': chatRoomId,
    'senderId': senderId,
    'content': content,
    // Convert DateTime to ISO 8601 string for JSON serialization
    'timestamp': timestamp.toIso8601String(),
    'messageType': messageType,
  };
}
