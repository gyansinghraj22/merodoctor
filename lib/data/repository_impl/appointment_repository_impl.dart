// lib/features/appointment/data/repositories/appointment_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:merodoctor/core/errors/failures.dart';
import 'package:merodoctor/data/data_source/appointment_remote_datasources.dart';
import 'package:merodoctor/data/model/appointment_model.dart';
import 'package:merodoctor/domain/repository/appointment_repository.dart';

/// Implements the [AppointmentRepository] contract.
///
/// This class handles all appointment-related data operations, abstracting
/// the data source and providing a clean interface for booking, retrieving,
/// and managing appointments.
class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AppointmentModel>> getAppointmentById(
      String appointmentId) async {
    try {
      final appointment =
          await remoteDataSource.getAppointmentById(appointmentId);
      return Right(appointment);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AppointmentModel>>> getUpcomingAppointments(
      String userId) async {
    try {
      final appointments =
          await remoteDataSource.getUpcomingAppointments(userId);
      return Right(appointments);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AppointmentModel>>> getPastAppointments(
      String userId) async {
    try {
      final appointments = await remoteDataSource.getPastAppointments(userId);
      return Right(appointments);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AppointmentModel>> bookAppointment(
      AppointmentModel appointment) async {
    try {
      final newAppointment =
          await remoteDataSource.bookAppointment(appointment);
      return Right(newAppointment);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateAppointmentStatus(
      String appointmentId, String newStatus) async {
    try {
      await remoteDataSource.updateAppointmentStatus(appointmentId, newStatus);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId) async {
    try {
      await remoteDataSource.cancelAppointment(appointmentId);
      return const Right(null);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AppointmentModel>> getAppointmentDetails(
      String appointmentId) async {
    try {
      final appointment =
          await remoteDataSource.getAppointmentDetails(appointmentId);
      return Right(appointment);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}