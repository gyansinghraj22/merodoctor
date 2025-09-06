// lib/core/entities/notification.dart
import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String notificationId;
  final String userId;
  final String type;
  final String message;
  final bool isRead;
  final DateTime createdAt;
  final List<String> sendVia;
  final String? relatedId;

  const NotificationEntity({
    required this.notificationId,
    required this.userId,
    required this.type,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.sendVia,
    this.relatedId,
  });

  @override
  List<Object?> get props => [
        notificationId,
        userId,
        type,
        message,
        isRead,
        createdAt,
        sendVia,
        relatedId,
      ];
}