// lib/features/notification/domain/repositories/notification_repository.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/model/notification_model.dart';

abstract class NotificationRepository {
  /// Sends a notification to a specific user.
  Future<Either<Failure, void>> sendNotification(NotificationModel notification);

  /// Retrieves all notifications for a given user.
  Future<Either<Failure, List<NotificationModel>>> getNotificationsForUser(
      String userId);

  /// Marks a specific notification as read.
  Future<Either<Failure, void>> markNotificationAsRead(String notificationId);

  /// Marks all of a user's notifications as read.
  Future<Either<Failure, void>> markAllNotificationsAsRead(String userId);

  /// Retrieves the count of a user's unread notifications.
  Future<Either<Failure, int>> getUnreadNotificationsCount(String userId);
}