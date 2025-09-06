import 'package:merodoctor/domain/entities/chat_room_enity.dart';

/// Represents the data model for a Chat Room, extending ChatRoomEntity.
/// This class handles JSON serialization and deserialization.
class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel({
    required super.chatRoomId,
    required super.appointmentId,
    required super.createdAt,
  });

  /// Factory constructor to create a ChatRoomModel instance from a JSON map.
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
    chatRoomId: json['chatRoomId'] as int,
    appointmentId: json['appointmentId'] as int,
    // Parse ISO 8601 string back to DateTime
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  /// Converts this ChatRoomModel instance to a JSON-compatible map.

  Map<String, dynamic> toJson() => {
    'chatRoomId': chatRoomId,
    'appointmentId': appointmentId,
    // Convert DateTime to ISO 8601 string for JSON serialization
    'createdAt': createdAt.toIso8601String(),
  };
}
