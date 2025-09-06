class ChatRoomEntity {
  final int chatRoomId;
  final int appointmentId;
  final DateTime createdAt;

  ChatRoomEntity({
    required this.chatRoomId,
    required this.appointmentId,
    required this.createdAt,
  });
}
