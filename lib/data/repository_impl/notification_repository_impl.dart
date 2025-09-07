// lib/features/notification/data/repositories/notification_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/notification_remote_datasources.dart';
import 'package:merodoctor/data/model/notification_model.dart';
import 'package:merodoctor/domain/repository/notification_repository.dart';

/// Implements the [NotificationRepository] contract.
///
/// This class is responsible for sending, retrieving, and managing notifications,
/// ensuring a consistent flow of information to the end user.
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> sendNotification(NotificationModel notification) async {
    try {
      await remoteDataSource.sendNotification(notification);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotificationsForUser(
      String userId) async {
    try {
      final notifications =
          await remoteDataSource.getNotificationsForUser(userId);
      return Right(notifications);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationAsRead(String notificationId) async {
    try {
      await remoteDataSource.markNotificationAsRead(notificationId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markAllNotificationsAsRead(String userId) async {
    try {
      await remoteDataSource.markAllNotificationsAsRead(userId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadNotificationsCount(String userId) async {
    try {
      final count = await remoteDataSource.getUnreadNotificationsCount(userId);
      return Right(count);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}