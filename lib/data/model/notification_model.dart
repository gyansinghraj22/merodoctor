// lib/features/notification/data/models/notification_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/domain/entities/notification_entity.dart';
// import 'package:your_app/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.notificationId,
    required super.userId,
    required super.type,
    required super.message,
    required super.isRead,
    required super.createdAt,
    required super.sendVia,
    super.relatedId,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      notificationId: doc.id,
      userId: data['userId'] as String,
      type: data['type'] as String,
      message: data['message'] as String,
      isRead: data['isRead'] as bool,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      sendVia: List<String>.from(data['sendVia']),
      relatedId: data['relatedId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'type': type,
      'message': message,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
      'sendVia': sendVia,
      'relatedId': relatedId,
    };
  }
}