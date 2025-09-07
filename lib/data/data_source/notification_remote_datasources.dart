// lib/features/notification/data/datasources/notification_remote_data_source.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merodoctor/data/model/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<void> sendNotification(NotificationModel notification);
  Future<List<NotificationModel>> getNotificationsForUser(String userId);
  Future<void> markNotificationAsRead(String notificationId);
  Future<void> markAllNotificationsAsRead(String userId);
  Future<int> getUnreadNotificationsCount(String userId);
}


class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotificationRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<void> sendNotification(NotificationModel notification) async {
    // In a real-world app, this would trigger a server-side function to
    // send a push notification via Firebase Cloud Messaging (FCM).
    await _firestore
        .collection('notifications')
        .add(notification.toFirestore());
  }

  @override
  Future<List<NotificationModel>> getNotificationsForUser(String userId) async {
    final querySnapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => NotificationModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  Future<void> markAllNotificationsAsRead(String userId) async {
    final querySnapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  @override
  Future<int> getUnreadNotificationsCount(String userId) async {
    final querySnapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .count()
        .get();
    return querySnapshot.count!;
  }
}